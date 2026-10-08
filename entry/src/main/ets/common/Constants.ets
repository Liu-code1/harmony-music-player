import { PlayMode } from '../model/SongModel'

/**
 * App-wide color palette
 */
export class Colors {
  static readonly primary: string = '#FF3B30'
  static readonly primaryLight: string = '#FF6B6B'
  static readonly background: string = '#F5F5F5'
  static readonly cardBackground: string = '#FFFFFF'
  static readonly textPrimary: string = '#1A1A1A'
  static readonly textSecondary: string = '#8E8E93'
  static readonly textHint: string = '#C7C7CC'
  static readonly divider: string = '#E5E5EA'
  static readonly tabActive: string = '#FF3B30'
  static readonly tabInactive: string = '#8E8E93'
  static readonly playerBackground: string = '#1C1C1E'
  static readonly likeActive: string = '#FF3B30'
  static readonly goldAccent: string = '#FFD60A'
  static readonly successGreen: string = '#34C759'
}

/**
 * Dimension constants
 */
export class Dimensions {
  static readonly tabBarHeight: number = 56
  static readonly miniPlayerHeight: number = 56
  static readonly playerControlHeight: number = 80
  static readonly songCoverSize: number = 56
  static readonly playlistCoverSize: number = 140
  static readonly bannerHeight: number = 160
  static readonly avatarSize: number = 64
  static readonly iconSmall: number = 20
  static readonly iconMedium: number = 24
  static readonly iconLarge: number = 32
  static readonly horizontalPadding: number = 16
  static readonly borderRadius: number = 12
  static readonly borderRadiusLarge: number = 20
  static readonly fontSizeXS: number = 10
  static readonly fontSizeSM: number = 12
  static readonly fontSizeMD: number = 14
  static readonly fontSizeLG: number = 16
  static readonly fontSizeXL: number = 18
  static readonly fontSizeXXL: number = 22
  static readonly fontSizeTitle: number = 28
  static readonly statusBarHeight: number = 44
}

/**
 * Play mode display text
 */
export function getPlayModeLabel(mode: PlayMode): string {
  switch (mode) {
    case PlayMode.SEQUENTIAL:
      return '顺序播放'
    case PlayMode.SINGLE_LOOP:
      return '单曲循环'
    case PlayMode.SHUFFLE:
      return '随机播放'
    case PlayMode.LIST_LOOP:
      return '列表循环'
    default:
      return '顺序播放'
  }
}

/**
 * Play mode icon resource references
 */
export function getPlayModeIconResource(mode: PlayMode): Resource {
  switch (mode) {
    case PlayMode.SEQUENTIAL:
      return $r('app.media.ic_mode_sequential')
    case PlayMode.SINGLE_LOOP:
      return $r('app.media.ic_mode_single')
    case PlayMode.SHUFFLE:
      return $r('app.media.ic_mode_shuffle')
    case PlayMode.LIST_LOOP:
      return $r('app.media.ic_mode_loop')
    default:
      return $r('app.media.ic_mode_loop')
  }
}

/**
 * Tab bar definitions (4 tabs, player is not a tab)
 */
export class TabItem {
  id: number
  name: string
  icon: Resource
  iconActive: Resource

  constructor(id: number, name: string, icon: Resource, iconActive: Resource) {
    this.id = id
    this.name = name
    this.icon = icon
    this.iconActive = iconActive
  }
}

export function getTabItems(): TabItem[] {
  return [
    new TabItem(0, '发现', $r('app.media.ic_tab_home'), $r('app.media.ic_tab_home_filled')),
    new TabItem(1, '搜索', $r('app.media.ic_tab_search'), $r('app.media.ic_tab_search_filled')),
    new TabItem(2, '动态', $r('app.media.ic_tab_library'), $r('app.media.ic_tab_library_filled')),
    new TabItem(3, '我的', $r('app.media.ic_tab_profile'), $r('app.media.ic_tab_profile_filled')),
  ]
}

/**
 * Search category tabs
 */
export const SEARCH_CATEGORIES: string[] = ['综合', '歌曲', '歌手', '专辑', '歌单']
