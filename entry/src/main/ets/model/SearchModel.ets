import { Song } from './SongModel'
import { Playlist } from './PlaylistModel'

/**
 * Search history entry
 */
export interface SearchHistory {
  id: string
  keyword: string
  searchedAt: number    // timestamp
}

/**
 * Hot search term
 */
export interface HotSearch {
  id: string
  keyword: string
  searchCount: number
  tag: string            // "热", "新", "爆" etc.
}

/**
 * Search suggestion (auto-complete)
 */
export interface SearchSuggestion {
  id: string
  keyword: string
  type: 'song' | 'artist' | 'album' | 'playlist'
  count: number          // related result count
}

/**
 * Aggregated search results
 */
export interface SearchResults {
  songs: Song[]
  artists: SearchArtist[]
  albums: SearchAlbum[]
  playlists: Playlist[]
}

export interface SearchArtist {
  id: string
  name: string
  avatarUrl: string
  songCount: number
  albumCount: number
}

export interface SearchAlbum {
  id: string
  name: string
  coverUrl: string
  artist: string
  songCount: number
  releaseYear: number
}
