import { Song } from './SongModel'

/**
 * Playlist data model
 */
export interface Playlist {
  id: string
  name: string
  coverUrl: string
  description: string
  songCount: number
  playCount: number
  creator: string
  songs: Song[]
  tags: string[]
  isCreatedByUser: boolean
  isCollected: boolean
}

/**
 * Home page banner
 */
export interface Banner {
  id: string
  imageUrl: string
  title: string
  linkType: 'playlist' | 'song' | 'chart' | 'url'
  linkId: string
}

/**
 * Home page section config
 */
export interface HomeSection {
  type: 'banner' | 'recommend' | 'popular' | 'newSongs' | 'chart' | 'recent'
  title: string
  data: Banner[] | Playlist[] | Song[]
}
