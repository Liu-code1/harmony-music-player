#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Generate defense PPT for Royal Music HarmonyOS App
"""

from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.enum.shapes import MSO_SHAPE
import os

# ── Color Palette ───
PRIMARY = RGBColor(0xFF, 0x3B, 0x30)      # red accent
PRIMARY_LIGHT = RGBColor(0xFF, 0x6B, 0x6B)
DARK_BG = RGBColor(0x1C, 0x1C, 0x1E)       # player bg
WHITE = RGBColor(0xFF, 0xFF, 0xFF)
TEXT_DARK = RGBColor(0x1A, 0x1A, 0x1A)
TEXT_SEC = RGBColor(0x8E, 0x8E, 0x93)
TEXT_HINT = RGBColor(0xC7, 0xC7, 0xCC)
CARD_BG = RGBColor(0xF5, 0xF5, 0xF5)
GOLD = RGBColor(0xFF, 0xD6, 0x0A)
GREEN = RGBColor(0x34, 0xC7, 0x59)

OUTPUT_PATH = r"F:\music\23HCIP卓越软件工程师2班-2023103011053-刘巧玲.pptx"

prs = Presentation()
prs.slide_width = Inches(13.333)  # 16:9 widescreen
prs.slide_height = Inches(7.5)

# ── Helper functions ───

def add_bg(slide, color=WHITE):
    """Set solid background color"""
    bg = slide.background
    fill = bg.fill
    fill.solid()
    fill.fore_color.rgb = color

def add_rect(slide, left, top, width, height, fill_color=None, border_color=None):
    """Add a rectangle shape"""
    shape = slide.shapes.add_shape(MSO_SHAPE.RECTANGLE, left, top, width, height)
    shape.line.fill.background()
    if fill_color:
        shape.fill.solid()
        shape.fill.fore_color.rgb = fill_color
    if border_color:
        shape.line.color.rgb = border_color
    return shape

def add_text_box(slide, left, top, width, height, text, font_size=18,
                 color=TEXT_DARK, bold=False, align=PP_ALIGN.LEFT, font_name='Microsoft YaHei'):
    """Add a text box with single text"""
    txBox = slide.shapes.add_textbox(left, top, width, height)
    tf = txBox.text_frame
    tf.word_wrap = True
    p = tf.paragraphs[0]
    p.text = text
    p.font.size = Pt(font_size)
    p.font.color.rgb = color
    p.font.bold = bold
    p.font.name = font_name
    p.alignment = align
    return txBox

def add_rich_text_box(slide, left, top, width, height, paragraphs_data):
    """Add text box with multiple styled paragraphs.
    paragraphs_data: list of (text, font_size, color, bold, align) tuples
    """
    txBox = slide.shapes.add_textbox(left, top, width, height)
    tf = txBox.text_frame
    tf.word_wrap = True
    for i, (text, font_size, color, bold, align) in enumerate(paragraphs_data):
        if i == 0:
            p = tf.paragraphs[0]
        else:
            p = tf.add_paragraph()
        p.text = text
        p.font.size = Pt(font_size)
        p.font.color.rgb = color
        p.font.bold = bold
        p.font.name = 'Microsoft YaHei'
        p.alignment = align
        p.space_after = Pt(6)
    return txBox

def add_bottom_bar(slide):
    """Add a thin accent bar at the bottom"""
    add_rect(slide, Inches(0), Inches(7.3), Inches(13.333), Inches(0.05), PRIMARY)
    add_rect(slide, Inches(0), Inches(7.35), Inches(13.333), Inches(0.15), DARK_BG)

def add_slide_number(slide, num, total):
    """Add slide number at bottom-right"""
    add_text_box(slide, Inches(11.8), Inches(7.05), Inches(1.2), Inches(0.3),
                 f'{num} / {total}', font_size=10, color=TEXT_HINT, align=PP_ALIGN.RIGHT)

def add_title_accent(slide, text, subtitle=None):
    """Big title with red accent underline"""
    add_text_box(slide, Inches(0.8), Inches(0.5), Inches(11), Inches(0.8),
                 text, font_size=36, color=TEXT_DARK, bold=True)
    add_rect(slide, Inches(0.8), Inches(1.3), Inches(1.2), Inches(0.06), PRIMARY)
    if subtitle:
        add_text_box(slide, Inches(0.8), Inches(1.45), Inches(11), Inches(0.5),
                     subtitle, font_size=14, color=TEXT_SEC)

def make_card(slide, left, top, width, height, title, items, icon_char='●'):
    """Make a content card with title and bullet items"""
    # Card background
    card = add_rect(slide, left, top, width, height, WHITE)
    card.shadow.inherit = False

    # Title
    add_text_box(slide, left + Inches(0.25), top + Inches(0.15), width - Inches(0.5), Inches(0.45),
                 title, font_size=16, color=PRIMARY, bold=True)

    # Items
    y_offset = top + Inches(0.6)
    for item in items:
        add_text_box(slide, left + Inches(0.35), y_offset, width - Inches(0.6), Inches(0.3),
                     f'{icon_char}  {item}', font_size=11, color=TEXT_DARK)
        y_offset += Inches(0.28)

def make_cover():
    """Cover / Title slide"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])  # blank
    add_bg(slide, DARK_BG)

    # Gradient-like accent blocks
    add_rect(slide, Inches(0), Inches(0), Inches(13.333), Inches(0.08), PRIMARY)
    add_rect(slide, Inches(0), Inches(0.08), Inches(13.333), Inches(0.02), PRIMARY_LIGHT)

    # Left accent bar
    add_rect(slide, Inches(0.8), Inches(2.2), Inches(0.08), Inches(3.2), PRIMARY)

    # Title
    add_text_box(slide, Inches(1.2), Inches(2.2), Inches(10), Inches(1.2),
                 'Royal Music', font_size=60, color=WHITE, bold=True)
    add_text_box(slide, Inches(1.2), Inches(3.2), Inches(10), Inches(0.7),
                 '基于HarmonyOS的鸿蒙音乐播放器', font_size=28, color=PRIMARY_LIGHT)

    # Divider line
    add_rect(slide, Inches(1.2), Inches(4.0), Inches(4.5), Inches(0.015), RGBColor(0x60, 0x60, 0x60))

    # Info
    add_text_box(slide, Inches(1.2), Inches(4.3), Inches(8), Inches(0.5),
                 '23HCIP卓越软件工程师2班  |  2023103011053  |  刘巧玲', font_size=18, color=TEXT_HINT)
    add_text_box(slide, Inches(1.2), Inches(4.8), Inches(8), Inches(0.5),
                 'HarmonyOS NEXT · ArkTS · ArkUI · MVVM架构', font_size=14, color=TEXT_SEC)

    add_text_box(slide, Inches(1.2), Inches(6.5), Inches(8), Inches(0.4),
                 '毕业设计答辩', font_size=16, color=TEXT_HINT)

def make_toc():
    """Table of Contents"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)

    add_title_accent(slide, '目  录', 'CONTENTS')
    add_slide_number(slide, 2, 14)

    sections = [
        ('01', '项目背景与选题意义', '项目来源、市场分析与开发目标'),
        ('02', '技术栈与开发环境', 'HarmonyOS生态、ArkTS语言、架构选型'),
        ('03', '系统架构设计', 'MVVM分层架构、组件树、数据流'),
        ('04', '功能模块概览', '12个页面、4大Tab、核心播放器'),
        ('05', '核心模块详解 —— 首页与发现', 'Banner轮播、推荐算法、排行榜、最近播放'),
        ('06', '核心模块详解 —— 搜索与音乐库', '热搜榜、联想搜索、歌单管理、动态Feed'),
        ('07', '核心模块详解 —— 播放器', '音频引擎、歌词同步、播放模式、控制交互'),
        ('08', '核心模块详解 —— 个人中心', '用户主页、歌单管理、下载管理、设置'),
        ('09', '技术亮点', 'MVVM数据驱动、播放引擎、组件化、深色模式'),
        ('10', '项目总结与展望', '完成度分析、技术收获、未来规划'),
    ]

    y_start = Inches(1.9)
    for i, (num, title, desc) in enumerate(sections):
        y = y_start + i * Inches(0.48)

        # Number circle
        circle = slide.shapes.add_shape(MSO_SHAPE.OVAL, Inches(1.2), y, Inches(0.4), Inches(0.4))
        circle.fill.solid()
        circle.fill.fore_color.rgb = PRIMARY if i < 3 else DARK_BG
        circle.line.fill.background()
        tf = circle.text_frame
        tf.paragraphs[0].text = num
        tf.paragraphs[0].font.size = Pt(12)
        tf.paragraphs[0].font.color.rgb = WHITE
        tf.paragraphs[0].font.bold = True
        tf.paragraphs[0].font.name = 'Microsoft YaHei'
        tf.paragraphs[0].alignment = PP_ALIGN.CENTER

        # Title + Description
        add_text_box(slide, Inches(1.85), y - Inches(0.02), Inches(8), Inches(0.28),
                     title, font_size=16, color=TEXT_DARK, bold=True)
        add_text_box(slide, Inches(1.85), y + Inches(0.22), Inches(8), Inches(0.22),
                     desc, font_size=11, color=TEXT_SEC)

def make_background():
    """Project Background"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '项目背景与选题意义', 'PROJECT BACKGROUND')
    add_slide_number(slide, 3, 14)

    # Left column - Background
    make_card(slide, Inches(0.6), Inches(2.1), Inches(5.8), Inches(2.4),
              '📋  项目背景', [
                  'HarmonyOS是华为自主研发的国产操作系统，市场份额快速增长',
                  '当前鸿蒙生态应用数量快速增长，但高质量音乐App相对稀缺',
                  '用户对跨设备无缝流转的听歌体验需求日益增长',
                  'HarmonyOS NEXT (API 21) 提供全新ArkUI声明式开发范式',
                  '项目定位：构建一款功能完善、体验流畅的鸿蒙原生音乐App',
              ])

    make_card(slide, Inches(6.8), Inches(2.1), Inches(5.8), Inches(2.4),
              '🎯  选题意义', [
                  '技术价值：掌握HarmonyOS应用开发全流程（MVVM + ArkTS）',
                  '生态价值：为鸿蒙生态贡献高质量音乐类应用参考实现',
                  '学习价值：深入理解音频播放、歌词同步等核心技术',
                  '实用价值：具备真实可用性，覆盖日常听歌全场景需求',
                  '架构价值：MVVM + 组件化设计可直接复用于商业项目',
              ])

    # Bottom card - Goals
    make_card(slide, Inches(0.6), Inches(2.1+2.6), Inches(12.0), Inches(3.0),
              '🚀  开发目标与需求来源', [
                  '需求来源：参考主流音乐App（网易云音乐、QQ音乐、Spotify），提炼核心功能',
                  '目标1：实现完整的5大Tab结构（发现/搜索/音乐库/播放器/个人中心）—— 共计12个页面',
                  '目标2：基于AVPlayer实现完整音频播放引擎，支持4种播放模式（顺序/单曲/随机/列表循环）',
                  '目标3：实现歌词逐行同步滚动、播放进度拖拽等核心交互',
                  '目标4：实现搜索联想、热搜榜、歌单管理、下载管理等完整业务流程',
              ])

def make_tech_stack():
    """Technology Stack"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '技术栈与开发环境', 'TECHNOLOGY STACK')
    add_slide_number(slide, 4, 14)

    # 3-column layout
    tech_groups = [
        ('🖥️  开发环境', [
            'DevEco Studio (官方IDE)',
            'Hvigor 构建系统',
            'HarmonyOS SDK 6.0.1(21)',
            '兼容API 6.0.1(21)',
            'Stage 应用模型',
            'Windows 11 开发平台',
        ]),
        ('🔧  核心技术', [
            'ArkTS (TypeScript超集)',
            'ArkUI 声明式UI框架',
            'MVVM 架构模式',
            '@Observed 响应式状态',
            'AVPlayer 音频引擎',
            'Router 页面导航',
        ]),
        ('📦  工程化', [
            'oh-package 包管理',
            'Hypium 测试框架',
            '代码混淆 (release)',
            'Linter 静态检查',
            '安全加密规则集',
            'Git 版本控制',
        ]),
    ]

    for i, (title, items) in enumerate(tech_groups):
        x = Inches(0.6) + i * Inches(4.1)
        make_card(slide, x, Inches(2.1), Inches(3.8), Inches(3.5), title, items)

    # Bottom row - project scale
    scale_items = [
        '📁  12个页面文件',
        '🧩  8个可复用组件',
        '📊  4个数据模型层',
        '🎵  20首Mock歌曲数据',
        '📋  10个Mock歌单',
        '🏷️  4个排行榜',
    ]
    y_bot = Inches(6.0)
    for i, item in enumerate(scale_items):
        x = Inches(0.6) + i * Inches(2.15)
        card = add_rect(slide, x, y_bot, Inches(1.95), Inches(0.75), PRIMARY)
        add_text_box(slide, x + Inches(0.1), y_bot + Inches(0.15), Inches(1.75), Inches(0.45),
                     item, font_size=13, color=WHITE, bold=True, align=PP_ALIGN.CENTER)

def make_architecture():
    """System Architecture"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '系统架构设计', 'SYSTEM ARCHITECTURE')
    add_slide_number(slide, 5, 14)

    # Architecture layers (top-down)
    layers = [
        ('View 层 (Pages & Components)', [
            '12 Pages: Splash, Index(Home+Search+Library+Profile), Player, PlaylistDetail, SongList, SearchResult, Settings, Downloads',
            '8 Components: TabBar, MiniPlayer, BannerCarousel, SongListItem, PlaylistCard, SectionHeader, SearchBar, PlayControlBar, LyricView',
        ], PRIMARY),
        ('ViewModel 层 (状态管理)', [
            'PlayerViewModel (@Observed singleton): 全局播放状态、当前歌曲、播放列表、播放模式、进度控制',
            '@Provide/@Consume 跨组件状态注入，@Link/@Prop 父子双向绑定',
        ], RGBColor(0x00, 0x7A, 0xFF)),
        ('Model 层 (数据模型)', [
            'Song (id, name, artist, album, duration, coverUrl, sourceUrl, isLiked, isDownloaded)',
            'Playlist · User · Chart · Banner · HotSearch · SearchResults · Comment · LyricLine · PlayMode enum',
        ], RGBColor(0x34, 0xC7, 0x59)),
        ('Service 层 (基础设施)', [
            'AudioPlayer: AVPlayer封装 (play/pause/resume/seek/stop) · 进度模拟fallback · 单例模式',
            'MockData: 20首歌曲 · 10个歌单 · 4个排行榜 · 10个热搜词 · 搜索/联想算法',
        ], RGBColor(0xFF, 0x95, 0x00)),
    ]

    for i, (title, items, color) in enumerate(layers):
        y = Inches(1.9) + i * Inches(1.28)

        # Layer colored bar + title
        bar = add_rect(slide, Inches(0.6), y, Inches(0.15), Inches(1.05), color)
        add_text_box(slide, Inches(1.0), y + Inches(0.05), Inches(11), Inches(0.3),
                     title, font_size=15, color=color, bold=True)

        for j, item in enumerate(items):
            add_text_box(slide, Inches(1.3), y + Inches(0.38) + j * Inches(0.24),
                         Inches(11), Inches(0.22),
                         f'•  {item}', font_size=10, color=TEXT_DARK)

    # Side note
    add_text_box(slide, Inches(0.6), Inches(7.05), Inches(11), Inches(0.3),
                 '架构特点：严格遵循 MVVM 分层，View 不直接操作数据，通过 ViewModel 完成状态驱动更新。AudioPlayer 与 PlayerViewModel 均为单例模式，全局唯一实例。',
                 font_size=10, color=TEXT_SEC)

def make_features_overview():
    """Feature Overview"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '功能模块概览', 'FEATURE OVERVIEW')
    add_slide_number(slide, 6, 14)

    modules = [
        ('🏠  首页', '发现', [
            'Banner轮播 (6个运营位)',
            '为你推荐 (算法推荐)',
            '热门歌单 (6个分类)',
            '新歌速递 (8首最新)',
            '排行榜 (4大榜单)',
            '最近播放 (10首)',
        ]),
        ('🔍  搜索', '搜索', [
            '关键词搜索 (歌曲/歌手/专辑)',
            '热搜榜 (10条实时)',
            '搜索历史 (最多15条)',
            '联想补全 (实时匹配)',
            '分类筛选Tab (综合/歌曲/歌手/专辑/歌单)',
            '搜索结果列表',
        ]),
        ('🎵  播放器', '核心', [
            '大图专辑封面 (旋转动画)',
            '可拖拽进度条 + 时长显示',
            '歌词逐行同步滚动',
            '4种播放模式切换',
            '播放控制 (上/下/暂停)',
            '收藏/下载/评论/分享/更多',
        ]),
        ('📱  个人中心', '我的', [
            '用户主页 (头像/昵称/签名)',
            '关注数/粉丝数/周报',
            'VIP等级 & 徽章系统',
            '自建歌单管理',
            '下载管理 (批量删除)',
            '设置 (主题切换/清缓存/退出)',
        ]),
    ]

    for i, (title, subtitle, items) in enumerate(modules):
        x = Inches(0.5) + (i % 2) * Inches(6.3)
        y = Inches(2.0) + (i // 2) * Inches(2.65)

        # Header
        add_text_box(slide, x + Inches(0.2), y, Inches(5.8), Inches(0.35),
                     title, font_size=18, color=PRIMARY, bold=True)
        add_text_box(slide, x + Inches(0.2), y + Inches(0.32), Inches(5.8), Inches(0.2),
                     subtitle, font_size=10, color=TEXT_HINT)

        # Card
        make_card(slide, x, y + Inches(0.55), Inches(6.0), Inches(1.85), '', items, '▸')

def make_home_detail():
    """Home Page Detail"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '核心模块详解 — 首页与发现', 'HOME & DISCOVER')
    add_slide_number(slide, 7, 14)

    make_card(slide, Inches(0.5), Inches(2.0), Inches(6.0), Inches(2.2),
              '🎠  Banner轮播', [
                  'Swiper组件实现，支持自动播放（4秒间隔）',
                  '6个运营Banner位，自定义圆点指示器',
                  '点击跳转歌单详情/排行榜/歌曲播放',
                  '资源对应：app.media 40-45',
              ])

    make_card(slide, Inches(6.8), Inches(2.0), Inches(6.0), Inches(2.2),
              '📊  排行榜 & 为你推荐', [
                  '4大官方榜单：飙升榜/热歌榜/新歌榜/原创榜',
                  '每个榜单展示TOP3歌曲（歌名+歌手）',
                  '推荐歌单：横向滑动展示6个精选歌单',
                  '热门歌单：3列Grid布局，显示播放量',
              ])

    make_card(slide, Inches(0.5), Inches(2.0+2.4), Inches(6.0), Inches(2.2),
              '🆕  新歌速递 & 最近播放', [
                  '新歌速递：展示最新6首歌曲（带序号+封面）',
                  '最近播放：记录最近10首听歌历史',
                  '支持一键续播，从当前点击歌曲开始播放',
                  '复用 SongListItem 组件，保持UI一致性',
              ])

    make_card(slide, Inches(6.8), Inches(2.0+2.4), Inches(6.0), Inches(2.2),
              '🧩  首页技术实现', [
                  'Scroll垂直滚动容器 + 内嵌横向Scroll',
                  'SectionHeader 组件复用，统一模块标题',
                  '数据源：MockData层提供（getRecommendedPlaylists等）',
                  '点击事件链：首页 → 歌单详情 → 播放器/歌曲列表',
              ])

def make_search_detail():
    """Search & Library Detail"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '核心模块详解 — 搜索与音乐库', 'SEARCH & LIBRARY')
    add_slide_number(slide, 8, 14)

    make_card(slide, Inches(0.5), Inches(2.0), Inches(6.0), Inches(2.4),
              '🔍  搜索功能', [
                  '搜索栏：胶囊型SearchBar组件，支持TextInput实时输入',
                  '热搜榜：10条热门搜索词（爆/热/新标签），显示搜索量',
                  '搜索历史：最多15条，支持逐条删除和清空',
                  '联想搜索：输入时实时匹配歌曲名/歌手/歌单名',
                  '搜索结果：独立SearchResultPage展示，含分类Tab',
              ])

    make_card(slide, Inches(6.8), Inches(2.0), Inches(6.0), Inches(2.4),
              '📋  搜索数据流', [
                  'getSearchSuggestions()：小写匹配 + 去重 + Top8',
                  'searchSongs()：匹配歌名/歌手/专辑（大小写不敏感）',
                  'MockData包含20首中文经典歌曲数据',
                  '搜索结果页支持分类切换（综合/歌曲/歌手/专辑/歌单）',
                  '点击歌曲 → 播放器（带完整播放列表）',
              ])

    make_card(slide, Inches(0.5), Inches(2.0+2.6), Inches(6.0), Inches(2.2),
              '🎵  音乐库 (动态Feed)', [
                  '12条用户动态Feed流（分享歌曲+评论+点赞）',
                  '每条包含：用户头像、昵称、分享文案、歌曲卡片',
                  '支持点赞（红心切换 + 计数变化）',
                  '可直接从动态卡片播放关联歌曲',
              ])

    make_card(slide, Inches(6.8), Inches(2.0+2.6), Inches(6.0), Inches(2.2),
              '📁  搜索页技术细节', [
                  'Flex流式布局实现搜索历史标签',
                  '条件渲染：默认视图 / 联想视图 / 结果视图',
                  '@Link/@Prop实现搜索值与SearchBar双向绑定',
                  'History自动去重（重复词移到最前）',
              ])

def make_player_detail():
    """Player Page Detail"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, DARK_BG)
    add_bottom_bar(slide)
    add_text_box(slide, Inches(0.8), Inches(0.5), Inches(11), Inches(0.8),
                 '核心模块详解 — 播放器', font_size=36, color=WHITE, bold=True)
    add_rect(slide, Inches(0.8), Inches(1.3), Inches(1.2), Inches(0.06), PRIMARY)
    add_text_box(slide, Inches(0.8), Inches(1.45), Inches(11), Inches(0.5),
                 'PLAYER — 最核心的交互模块', font_size=14, color=TEXT_HINT)
    add_slide_number(slide, 9, 14)

    # Audio engine section
    make_card(slide, Inches(0.5), Inches(2.1), Inches(4.0), Inches(2.3),
              '🔊  音频引擎 AudioPlayer', [
                  '基于AVPlayer封装（media.createAVPlayer）',
                  '单例模式，全局唯一播放实例',
                  '核心API：play/pause/resume/stop/seek',
                  '进度回调：onProgress (1秒轮询)',
                  '完成回调：onComplete → 自动下一首',
                  'Fallback：播放失败时模拟进度',
              ])

    make_card(slide, Inches(4.8), Inches(2.1), Inches(4.0), Inches(2.3),
              '🎛️  PlayerViewModel', [
                  '@Observed响应式状态管理',
                  'playSong(歌曲, 列表, 索引) 统一入口',
                  '4种播放模式智能化切换：',
                  '  · 顺序播放 → 列表末尾停止',
                  '  · 单曲循环 → 自动从头播放',
                  '  · 随机播放 → 避免连续重复',
                  '  · 列表循环 → 循环切换',
              ])

    make_card(slide, Inches(9.1), Inches(2.1), Inches(4.0), Inches(2.3),
              '🎨  播放器UI', [
                  '深色渐变背景（4色渐变）',
                  '大图专辑封面（240px圆形+旋转动画）',
                  '可拖拽Slider进度条 + 时长显示',
                  '点击专辑图 ↔ 歌词视图切换',
                  '底部操作栏：收藏/下载/评论/分享/更多',
                  '播放模式图标+文字实时显示',
              ])

    # Lyrics section
    make_card(slide, Inches(0.5), Inches(2.1+2.5), Inches(6.3), Inches(2.0),
              '📝  歌词系统', [
                  '数据层：LyricLine { time: ms, text: string }',
                  'MOCK_LYRICS：3首歌曲完整歌词数据（晴天/七里香/光年之外）',
                  'LyricView组件：List滚动 + 当前行高亮（PRIMARY色）',
                  'getCurrentLineIndex()：二分查找定位当前歌词行',
                  '预留顶部40%和底部60%空白实现居中显示',
              ])

    make_card(slide, Inches(7.1), Inches(2.1+2.5), Inches(6.0), Inches(2.0),
              '🎮  交互细节', [
                  '前3秒内点击上一首 → 重新播放当前歌曲（而非切歌）',
                  '进度Slider范围0-100，通过 getProgress() 计算映射',
                  'like状态双向绑定（PlayerViewModel ↔ SongModel）',
                  'MiniPlayer悬浮条：首页可见当前播放，快速打开播放器',
                  '播放模式循环切换：4个mode → togglePlayMode() → 图标联动',
              ])

def make_profile_detail():
    """Profile & Settings Detail"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '核心模块详解 — 个人中心', 'PROFILE & SETTINGS')
    add_slide_number(slide, 10, 14)

    make_card(slide, Inches(0.5), Inches(2.0), Inches(6.0), Inches(2.3),
              '👤  个人主页 ProfilePage', [
                  '顶部：背景图（带暗色遮罩渐变）+ 头像+用户信息',
                  'VIP等级显示（Lv.5）+ 徽章系统（2枚）',
                  '数据卡片：周报(3) / 关注(128) / 粉丝(256)',
                  '听歌时长统计（76小时）',
                  'Tab切换：最近/本地/VIP/会员',
              ])

    make_card(slide, Inches(6.8), Inches(2.0), Inches(6.0), Inches(2.3),
              '📋  歌单与动态管理', [
                  '用户自建歌单列表（横向Row布局，封面+歌名+歌曲数）',
                  '内容分类Tab：音乐/播客/笔记',
                  '听歌排行入口',
                  '装扮入口（个性化设置）',
                  'Feed推荐流：作者推荐+内容卡片',
              ])

    make_card(slide, Inches(0.5), Inches(2.0+2.5), Inches(6.0), Inches(2.1),
              '⚙️  设置中心 SettingsPage', [
                  '账号管理：个人资料/账号安全/隐私设置',
                  '显示与外观：主题切换（跟随系统/浅色/深色）',
                  '存储与缓存：清理缓存（128.5MB）/下载位置',
                  '关于：版本信息(v1.0.0)/用户协议/隐私政策/开源许可',
                  '退出登录：带确认弹窗（取消/确定）',
              ])

    make_card(slide, Inches(6.8), Inches(2.0+2.5), Inches(6.0), Inches(2.1),
              '📥  下载管理 DownloadsPage', [
                  '筛选已下载歌曲（isDownloaded: true）',
                  '编辑模式：Checkbox多选 + 批量删除',
                  '统计信息：歌曲数量 + 总占用空间',
                  '点击播放 → 跳转播放器',
                  '空状态：图标+提示文案',
              ])

def make_tech_highlights():
    """Technical Highlights"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '技术亮点与创新', 'TECHNICAL HIGHLIGHTS')
    add_slide_number(slide, 11, 14)

    highlights = [
        ('🎯  MVVM数据驱动架构', [
            'View (Pages/Components) 不持有业务逻辑，通过PlayerViewModel统一管理播放状态',
            '@Observed + @Provide/@Consume实现全局响应式数据流',
            '状态变化自动触发UI更新，无需手动setState',
        ]),
        ('🔊  完整音频播放引擎', [
            'AVPlayer二次封装，支持play/pause/resume/stop/seek全生命周期',
            '4种播放模式 + 智能切歌逻辑（前3秒不跳歌、随机避免重复）',
            '双层容错：AVPlayer失败自动切换到模拟进度Fallback',
            '单例模式确保全局唯一播放实例，避免多实例冲突',
        ]),
        ('📝  歌词同步系统', [
            'LyricLine数据结构：精确到毫秒的时间戳映射',
            'getCurrentLineIndex() 逐行查找算法，根据播放进度定位当前行',
            '当前行：PRIMARY色高亮 + 字号放大 + 动画过渡',
            'List滚动容器实现完整歌词展示，点击切换专辑图/歌词视图',
        ]),
        ('🧩  组件化设计', [
            '8个可复用组件：TabBar/MiniPlayer/BannerCarousel/SongListItem/PlaylistCard/SectionHeader/SearchBar/PlayControlBar/LyricView',
            '统一的Props回调接口（onTabChange/onPlayClick/onBannerClick等）',
            '组件可在任意页面独立使用，降低耦合度',
            '统一的Constants设计系统：Colors/Dimensions/PlayMode',
        ]),
        ('🎨  设计系统', [
            'Colors类：13组颜色常量（primary/background/text/card/tab等）',
            'Dimensions类：25组尺寸常量（间距/圆角/字号/组件高度）',
            '支持深色模式配置文件（dark/element/color.json）',
            'Player渐变背景：4色渐变营造沉浸式体验',
        ]),
        ('🔒  工程化保障', [
            '代码安全：13条加密安全规则（禁止不安全的AES/RSA/SHA等）',
            '性能检查：@performance/recommended规则集',
            '代码风格：@typescript-eslint/recommended',
            '测试框架：Hypium (describe/it/expect API)',
            'Release混淆：通过obfuscation-rules.txt配置',
        ]),
    ]

    for i, (title, items) in enumerate(highlights):
        row = i // 2
        col = i % 2
        x = Inches(0.5) + col * Inches(6.2)
        y = Inches(1.8) + row * Inches(1.8)
        make_card(slide, x, y, Inches(6.0), Inches(1.6), title, items, '⚡')

def make_summary():
    """Summary & Future"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, WHITE)
    add_bottom_bar(slide)
    add_title_accent(slide, '项目总结与展望', 'SUMMARY & FUTURE')
    add_slide_number(slide, 12, 14)

    # Summary
    make_card(slide, Inches(0.5), Inches(2.0), Inches(6.0), Inches(2.4),
              '✅  项目完成情况', [
                  '✅ 完整实现4个主Tab + 1个独立播放器页',
                  '✅ 总计12个页面，代码量约3500+行ArkTS',
                  '✅ 8个复用组件 + 4个数据模型层',
                  '✅ 完整的MVVM架构（View/ViewModel/Model/Service）',
                  '✅ Mock数据集：20首歌曲/10个歌单/4个排行榜',
                  '✅ 4种播放模式 + 歌词同步系统',
              ])

    make_card(slide, Inches(6.8), Inches(2.0), Inches(6.0), Inches(2.4),
              '📈  技术收获', [
                  '🚀 掌握HarmonyOS ArkTS + ArkUI声明式开发',
                  '🏗️ 深入理解MVVM架构在实际项目中的应用',
                  '🔊 实践了AVPlayer音频引擎的封装与使用',
                  '🧩 提高了组件化设计与复用能力',
                  '🎨 系统学习了HarmonyOS Stage模型应用开发',
                  '🔒 建立了代码安全与工程化的规范意识',
              ])

    # Future
    make_card(slide, Inches(0.5), Inches(2.0+2.6), Inches(12.2), Inches(2.1),
              '🔮  未来展望', [
                  '接入真实API：对接音乐平台Open API（如网易云音乐API），替换Mock数据',
                  '分布式能力：实现HarmonyOS多设备协同（手机↔平板↔车机无缝流转）',
                  '音频可视化：添加频谱动画、波形图等可视化效果',
                  '社交功能：评论区、动态广场、好友互关、歌单分享',
                  '智能推荐：集成推荐算法，基于用户行为个性化推荐',
                  '性能优化：图片懒加载、列表虚拟化、内存管理',
              ])

def make_end():
    """Thank You slide"""
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    add_bg(slide, DARK_BG)

    add_rect(slide, Inches(0), Inches(0), Inches(13.333), Inches(0.08), PRIMARY)

    add_text_box(slide, Inches(1.2), Inches(2.5), Inches(11), Inches(1.0),
                 '感谢聆听', font_size=56, color=WHITE, bold=True, align=PP_ALIGN.CENTER)

    add_text_box(slide, Inches(1.2), Inches(3.8), Inches(11), Inches(0.8),
                 'THANK YOU', font_size=32, color=PRIMARY_LIGHT, align=PP_ALIGN.CENTER)

    add_rect(slide, Inches(4.5), Inches(4.7), Inches(4.3), Inches(0.015), RGBColor(0x60, 0x60, 0x60))

    add_text_box(slide, Inches(1.2), Inches(5.2), Inches(11), Inches(0.5),
                 '23HCIP卓越软件工程师2班  |  2023103011053  |  刘巧玲',
                 font_size=16, color=TEXT_HINT, align=PP_ALIGN.CENTER)
    add_text_box(slide, Inches(1.2), Inches(5.7), Inches(11), Inches(0.5),
                 'Royal Music — 基于HarmonyOS的鸿蒙音乐播放器',
                 font_size=14, color=TEXT_SEC, align=PP_ALIGN.CENTER)


# ── Generate All Slides ───

make_cover()          # 1
make_toc()            # 2
make_background()     # 3
make_tech_stack()     # 4
make_architecture()   # 5
make_features_overview()  # 6
make_home_detail()    # 7
make_search_detail()  # 8
make_player_detail()  # 9
make_profile_detail() # 10
make_tech_highlights()# 11
make_summary()        # 12
make_end()            # 13

# ── Save ───
prs.save(OUTPUT_PATH)
print(f"PPT saved to: {OUTPUT_PATH}")
print(f"Total slides: {len(prs.slides)}")
