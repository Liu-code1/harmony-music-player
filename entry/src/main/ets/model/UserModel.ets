import { Playlist } from './PlaylistModel'

/**
 * User profile model
 */
export interface User {
  id: string
  nickname: string
  avatarUrl: string
  signature: string
  followingCount: number
  followerCount: number
  likedSongsCount: number
  createdPlaylists: Playlist[]
  collectedPlaylists: Playlist[]
}

/**
 * Song comment model
 */
export interface Comment {
  id: string
  songId: string
  userId: string
  userNickname: string
  userAvatar: string
  content: string
  likeCount: number
  createdAt: string
  isLiked: boolean
}

/**
 * App settings
 */
export interface AppSettings {
  theme: 'light' | 'dark' | 'system'
  cacheSize: string
  appVersion: string
}
