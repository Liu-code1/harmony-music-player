/**
 * Song data model
 */
export interface Song {
  id: string
  name: string
  artist: string
  artistId: string
  album: string
  albumId: string
  duration: number       // milliseconds
  coverUrl: string
  sourceUrl: string
  isLiked: boolean
  isDownloaded: boolean
}

/**
 * Lyric line with timestamp
 */
export interface LyricLine {
  time: number           // milliseconds
  text: string
}

/**
 * Playing mode enum
 */
export enum PlayMode {
  SEQUENTIAL = 0,        // 顺序播放
  SINGLE_LOOP = 1,       // 单曲循环
  SHUFFLE = 2,           // 随机播放
  LIST_LOOP = 3          // 列表循环
}

/**
 * Chart entry
 */
export interface Chart {
  id: string
  name: string
  coverUrl: string
  description: string
  songs: Song[]
}

/**
 * Recently played song (with play timestamp)
 */
export interface RecentSong {
  song: Song
  playedAt: number       // timestamp
}
