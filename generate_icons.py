#!/usr/bin/env python3
"""
Generate placeholder PNG images for the HarmonyOS music app.
Creates cover art, app icons, banners, and UI asset images.
"""
import struct
import zlib
import os

def create_png(width, height, pixels):
    """Create a valid PNG file from raw RGBA pixel data."""
    def chunk(chunk_type, data):
        c = chunk_type + data
        crc = struct.pack('>I', zlib.crc32(c) & 0xffffffff)
        return struct.pack('>I', len(data)) + c + crc

    # PNG signature
    sig = b'\x89PNG\r\n\x1a\n'

    # IHDR
    ihdr_data = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    ihdr = chunk(b'IHDR', ihdr_data)

    # IDAT: raw image data with filter byte per row
    raw = b''
    for y in range(height):
        raw += b'\x00'  # filter: none
        for x in range(width):
            idx = (y * width + x) * 4
            raw += bytes(pixels[idx:idx+4])

    compressed = zlib.compress(raw)
    idat = chunk(b'IDAT', compressed)

    # IEND
    iend = chunk(b'IEND', b'')

    return sig + ihdr + idat + iend

def blend_colors(c1, c2, t):
    """Linear interpolation between two RGBA colors."""
    return tuple(int(c1[i] + (c2[i] - c1[i]) * t) for i in range(4))

def fill_gradient(width, height, color_top, color_bottom):
    """Create a vertical gradient fill."""
    pixels = []
    for y in range(height):
        t = y / (height - 1) if height > 1 else 0
        c = blend_colors(color_top, color_bottom, t)
        for x in range(width):
            pixels.extend(c)
    return pixels

def draw_circle(pixels, width, height, cx, cy, r, color):
    """Draw a filled circle onto pixels."""
    for y in range(height):
        for x in range(width):
            dx = x - cx
            dy = y - cy
            if dx*dx + dy*dy <= r*r:
                idx = (y * width + x) * 4
                # Alpha blending
                sr, sg, sb, sa = color
                dr, dg, db, da = pixels[idx:idx+4]
                a = sa / 255.0
                out_r = int(sr * a + dr * (1 - a))
                out_g = int(sg * a + dg * (1 - a))
                out_b = int(sb * a + db * (1 - a))
                out_a = min(255, da + sa)
                pixels[idx:idx+4] = [out_r, out_g, out_b, out_a]

def draw_rect(pixels, img_w, img_h, rx, ry, rw, rh, color, radius=0):
    """Draw a filled rectangle onto pixels (with optional corner radius)."""
    for y in range(max(0, ry), min(img_h, ry + rh)):
        for x in range(max(0, rx), min(img_w, rx + rw)):
            # Simple corner radius
            in_corner = False
            if radius > 0:
                for corner_x, corner_y in [(rx+radius, ry+radius), (rx+rw-radius, ry+radius),
                                           (rx+radius, ry+rh-radius), (rx+rw-radius, ry+rh-radius)]:
                    dx = x - corner_x
                    dy = y - corner_y
                    if (dx < 0 and dy < 0) or (dx > 0 and dy < 0) or (dx < 0 and dy > 0) or (dx > 0 and dy > 0):
                        if dx*dx + dy*dy > radius*radius and abs(dx) < radius and abs(dy) < radius:
                            in_corner = True
                            break
            if not in_corner:
                idx = (y * img_w + x) * 4
                sr, sg, sb, sa = color
                dr, dg, db, da = pixels[idx:idx+4]
                a = sa / 255.0
                pixels[idx:idx+4] = [
                    int(sr * a + dr * (1 - a)),
                    int(sg * a + dg * (1 - a)),
                    int(sb * a + db * (1 - a)),
                    min(255, da + sa)
                ]

# ========== Color palettes ==========
COVER_GRADIENTS = [
    ( (102, 126, 234, 255), (118, 75, 162, 255) ),   # Purple-blue
    ( (255, 107, 107, 255), (255, 142, 83, 255) ),   # Coral
    ( (78, 205, 196, 255), (69, 183, 209, 255) ),    # Teal
    ( (150, 206, 180, 255), (255, 234, 167, 255) ),  # Sage
    ( (221, 160, 221, 255), (255, 140, 66, 255) ),   # Plum-orange
    ( (255, 107, 129, 255), (255, 159, 67, 255) ),   # Pink-orange
    ( (72, 52, 212, 255), (165, 94, 234, 255) ),     # Deep purple
    ( (0, 210, 255, 255), (58, 123, 213, 255) ),     # Sky blue
    ( (252, 92, 125, 255), (255, 165, 0, 255) ),     # Sunset
    ( (32, 191, 107, 255), (0, 168, 255, 255) ),     # Green-blue
    ( (240, 147, 251, 255), (245, 87, 108, 255) ),   # Pink
    ( (250, 112, 154, 255), (254, 209, 100, 255) ),  # Warm
]

CHART_GRADIENTS = [
    ( (255, 59, 48, 255), (255, 107, 107, 255) ),    # Red
    ( (255, 149, 0, 255), (255, 204, 0, 255) ),      # Orange
    ( (52, 199, 89, 255), (48, 209, 88, 255) ),      # Green
    ( (0, 122, 255, 255), (100, 210, 255, 255) ),    # Blue
]

BANNER_GRADIENTS = [
    ( (255, 59, 48, 255), (255, 107, 107, 255) ),
    ( (78, 205, 196, 255), (69, 183, 209, 255) ),
    ( (102, 126, 234, 255), (118, 75, 162, 255) ),
    ( (255, 149, 0, 255), (255, 204, 0, 255) ),
    ( (150, 206, 180, 255), (255, 234, 167, 255) ),
    ( (221, 160, 221, 255), (255, 140, 66, 255) ),
]

MEDIA_DIR = 'entry/src/main/resources/base/media'
APPSCOPE_MEDIA_DIR = 'AppScope/resources/base/media'

def create_cover_image(filename, width, height, gradient_colors, overlay_circle=True):
    """Create a cover art placeholder with gradient + music note circle."""
    pixels = fill_gradient(width, height, gradient_colors[0], gradient_colors[1])

    if overlay_circle:
        # Dark semi-transparent circle in center (vinyl record look)
        cx, cy = width // 2, height // 2
        r = min(width, height) // 3
        draw_circle(pixels, width, height, cx, cy, r, (0, 0, 0, 80))
        # Inner circle
        draw_circle(pixels, width, height, cx, cy, r // 3, (0, 0, 0, 60))
        # Small accent dot
        draw_circle(pixels, width, height, cx + r//2, cy, r//6, (255, 255, 255, 40))

    png_data = create_png(width, height, pixels)

    filepath = os.path.join(MEDIA_DIR, filename)
    with open(filepath, 'wb') as f:
        f.write(png_data)
    print(f'Created: {filepath}')

def create_app_icon_bg(filename, width, height, color):
    """Create a solid color app icon background."""
    pixels = []
    for y in range(height):
        for x in range(width):
            pixels.extend(color)
    png_data = create_png(width, height, pixels)
    filepath = os.path.join(APPSCOPE_MEDIA_DIR, filename)
    with open(filepath, 'wb') as f:
        f.write(png_data)
    print(f'Created: {filepath}')
    # Also copy to entry media
    entry_path = os.path.join(MEDIA_DIR, filename)
    os.makedirs(os.path.dirname(entry_path), exist_ok=True)
    with open(entry_path, 'wb') as f:
        f.write(png_data)
    print(f'Created: {entry_path}')

def create_app_icon_fg(filename, width, height):
    """Create a music note foreground for app icon."""
    pixels = []
    # Transparent background
    for y in range(height):
        for x in range(width):
            pixels.extend([255, 255, 255, 0])

    # Draw simple music note shape in white
    cx, cy = width // 2, height // 2

    # Note head (circle)
    r = width // 5
    draw_circle(pixels, width, height, cx - r, cy + r, r, (255, 255, 255, 255))
    draw_circle(pixels, width, height, cx + r, cy + r//2, r, (255, 255, 255, 255))

    # Note stem (vertical line)
    stem_x = cx + r + r//2
    draw_rect(pixels, width, height, stem_x - width//30, cy - r*2, width//15, r*3 + r//2, (255, 255, 255, 255))

    # Flag
    draw_rect(pixels, width, height, stem_x, cy - r*2, r*2, r, (255, 255, 255, 255))

    png_data = create_png(width, height, pixels)
    filepath = os.path.join(APPSCOPE_MEDIA_DIR, filename)
    with open(filepath, 'wb') as f:
        f.write(png_data)
    print(f'Created: {filepath}')

def main():
    os.makedirs(MEDIA_DIR, exist_ok=True)
    os.makedirs(APPSCOPE_MEDIA_DIR, exist_ok=True)

    # ---- Cover art: 12 playlist covers (256x256) ----
    print('\n=== Generating playlist/song covers ===')
    for i in range(12):
        filename = f'cover_default_{i+1:02d}.png'
        colors = COVER_GRADIENTS[i % len(COVER_GRADIENTS)]
        create_cover_image(filename, 256, 256, colors)

    # ---- Cover art: default cover ----
    create_cover_image('cover_default.png', 256, 256, COVER_GRADIENTS[0])

    # ---- Chart covers: 4 charts (256x256) ----
    print('\n=== Generating chart covers ===')
    for i in range(4):
        filename = f'cover_chart_{i+1:02d}.png'
        colors = CHART_GRADIENTS[i % len(CHART_GRADIENTS)]
        create_cover_image(filename, 256, 256, colors, overlay_circle=False)

    # ---- Banner images: 6 banners (750x320) ----
    print('\n=== Generating banner images ===')
    for i in range(6):
        filename = f'banner_{i+1:02d}.png'
        colors = BANNER_GRADIENTS[i % len(BANNER_GRADIENTS)]
        create_cover_image(filename, 750, 320, colors, overlay_circle=False)

    # ---- App icon background: 216x216 ----
    print('\n=== Generating app icon layers ===')
    create_app_icon_bg('ic_launcher_background.png', 216, 216, (255, 59, 48, 255))

    # ---- App icon foreground: 216x216 ----
    create_app_icon_fg('ic_launcher_foreground.png', 216, 216)

    # ---- Start icon (splash): 216x216 ----
    pixels = []
    for y in range(216):
        for x in range(216):
            pixels.extend([255, 59, 48, 255])
    draw_circle(pixels, 216, 216, 108, 108, 50, (255, 255, 255, 200))
    png_data = create_png(216, 216, pixels)
    start_path = os.path.join(MEDIA_DIR, 'startIcon.png')
    with open(start_path, 'wb') as f:
        f.write(png_data)
    print(f'Created: {start_path}')

    # ---- Background and foreground placeholders ----
    bg_path = os.path.join(MEDIA_DIR, 'background.png')
    pixels = fill_gradient(216, 216, (255, 59, 48, 255), (255, 107, 107, 255))
    with open(bg_path, 'wb') as f:
        f.write(create_png(216, 216, pixels))
    print(f'Created: {bg_path}')

    fg_path = os.path.join(MEDIA_DIR, 'foreground.png')
    pixels_fg = []
    for y in range(216):
        for x in range(216):
            pixels_fg.extend([255, 255, 255, 0])
    draw_circle(pixels_fg, 216, 216, 108, 108, 45, (255, 255, 255, 200))
    with open(fg_path, 'wb') as f:
        f.write(create_png(216, 216, pixels_fg))
    print(f'Created: {fg_path}')

    # Also for AppScope
    for fname, is_bg in [('background.png', True), ('foreground.png', False)]:
        scope_path = os.path.join(APPSCOPE_MEDIA_DIR, fname)
        if is_bg:
            pixels2 = fill_gradient(216, 216, (255, 59, 48, 255), (255, 107, 107, 255))
        else:
            pixels2 = []
            for y in range(216):
                for x in range(216):
                    pixels2.extend([255, 255, 255, 0])
            draw_circle(pixels2, 216, 216, 108, 108, 45, (255, 255, 255, 220))
        with open(scope_path, 'wb') as f:
            f.write(create_png(216, 216, pixels2))
        print(f'Created: {scope_path}')

    print('\n=== All images generated successfully! ===')
    print(f'Total files created in: {MEDIA_DIR}')
    print(f'Total files created in: {APPSCOPE_MEDIA_DIR}')

if __name__ == '__main__':
    main()
