import { Song, PlayMode } from '../model/SongModel'
import { AudioPlayer } from '../common/AudioPlayer'

/**
 * Global playback state — @Observed for distributed reactivity.
 * Singleton pattern for global access across all pages.
 */
@Observed
export class PlayerViewModel {
  currentSong: Song | null = null
  playlist: Song[] = []
  currentIndex: number = -1
  playMode: PlayMode = PlayMode.LIST_LOOP
  isPlaying: boolean = false
  currentTime: number = 0
  duration: number = 0
  isLiked: boolean = false
  showPlayer: boolean = false

  private audioPlayer: AudioPlayer = AudioPlayer.getInstance()
  private static instance: PlayerViewModel | null = null

  private constructor() {
    this.audioPlayer.setOnProgress((time: number) => {
      this.currentTime = time
    })
    this.audioPlayer.setOnComplete(() => {
      this.onSongComplete()
    })
  }

  static getInstance(): PlayerViewModel {
    if (!PlayerViewModel.instance) {
      PlayerViewModel.instance = new PlayerViewModel()
    }
    return PlayerViewModel.instance
  }

  /**
   * Play a song from a playlist, starting at the given index.
   */
  playSong(song: Song, list: Song[] = [song], index: number = 0): void {
    if (!song) {
      console.warn('playSong: song is null or undefined')
      return
    }
    this.playlist = list && list.length > 0 ? list : [song]
    this.currentIndex = index >= 0 && index < this.playlist.length ? index : 0
    this.currentSong = song
    this.isLiked = !!song.isLiked
    this.duration = song.duration || 0
    this.currentTime = 0
    this.isPlaying = true
    this.showPlayer = true

    this.audioPlayer.play(song)
  }

  /**
   * Toggle play/pause.
   */
  togglePlay(): void {
    if (this.isPlaying) {
      this.pause()
    } else {
      this.resume()
    }
  }

  play(): void {
    if (this.currentSong) {
      this.isPlaying = true
      this.audioPlayer.resume()
    }
  }

  pause(): void {
    this.isPlaying = false
    this.audioPlayer.pause()
  }

  resume(): void {
    if (this.currentSong) {
      this.isPlaying = true
      this.audioPlayer.resume()
    }
  }

  /**
   * Play the next song based on play mode.
   */
  next(): void {
    if (!this.playlist || this.playlist.length === 0) return
    if (this.currentIndex < 0 || this.currentIndex >= this.playlist.length) {
      this.currentIndex = 0
    }

    let nextIndex = this.currentIndex
    switch (this.playMode) {
      case PlayMode.SEQUENTIAL:
        if (this.currentIndex < this.playlist.length - 1) {
          nextIndex = this.currentIndex + 1
        } else {
          // End of list — stop playback
          this.stop()
          return
        }
        break
      case PlayMode.SINGLE_LOOP:
        nextIndex = this.currentIndex
        break
      case PlayMode.SHUFFLE:
        nextIndex = Math.floor(Math.random() * this.playlist.length)
        // Avoid repeating the same song if possible
        if (nextIndex === this.currentIndex && this.playlist.length > 1) {
          nextIndex = (nextIndex + 1) % this.playlist.length
        }
        break
      case PlayMode.LIST_LOOP:
        nextIndex = (this.currentIndex + 1) % this.playlist.length
        break
    }

    const nextSong = this.playlist[nextIndex]
    if (!nextSong) return

    this.currentIndex = nextIndex
    this.currentSong = nextSong
    this.isLiked = !!nextSong.isLiked
    this.duration = nextSong.duration || 0
    this.currentTime = 0
    this.isPlaying = true
    this.audioPlayer.play(nextSong)
  }

  /**
   * Play the previous song.
   */
  prev(): void {
    if (!this.playlist || this.playlist.length === 0) return
    if (this.currentIndex < 0 || this.currentIndex >= this.playlist.length) {
      this.currentIndex = 0
    }
    // If more than 3 seconds in, restart current song instead
    if (this.currentTime > 3000) {
      this.currentTime = 0
      this.audioPlayer.seek(0)
      return
    }
    let prevIndex: number
    switch (this.playMode) {
      case PlayMode.SHUFFLE:
        prevIndex = Math.floor(Math.random() * this.playlist.length)
        break
      default:
        prevIndex = this.currentIndex <= 0 ? this.playlist.length - 1 : this.currentIndex - 1
        break
    }
    const prevSong = this.playlist[prevIndex]
    if (!prevSong) return

    this.currentIndex = prevIndex
    this.currentSong = prevSong
    this.isLiked = !!prevSong.isLiked
    this.duration = prevSong.duration || 0
    this.currentTime = 0
    this.isPlaying = true
    this.audioPlayer.play(prevSong)
  }

  /**
   * Toggle play mode cyclically.
   */
  togglePlayMode(): void {
    const modes = [PlayMode.LIST_LOOP, PlayMode.SEQUENTIAL, PlayMode.SINGLE_LOOP, PlayMode.SHUFFLE]
    const idx = modes.indexOf(this.playMode)
    this.playMode = modes[(idx + 1) % modes.length]
  }

  /**
   * Seek to position in the song.
   */
  seekTo(time: number): void {
    this.currentTime = time
    this.audioPlayer.seek(time)
  }

  /**
   * Toggle like status.
   */
  toggleLike(): void {
    this.isLiked = !this.isLiked
    if (this.currentSong) {
      this.currentSong.isLiked = this.isLiked
    }
  }

  /**
   * Stop playback.
   */
  stop(): void {
    this.isPlaying = false
    this.currentTime = 0
    this.audioPlayer.stop()
    this.showPlayer = false
  }

  /**
   * Called when the current song finishes playing.
   */
  private onSongComplete(): void {
    if (this.playMode === PlayMode.SINGLE_LOOP) {
      this.currentTime = 0
      this.isPlaying = true
      if (this.currentSong) {
        this.audioPlayer.play(this.currentSong)
      }
    } else if (this.playMode === PlayMode.SEQUENTIAL &&
               this.currentIndex >= this.playlist.length - 1) {
      this.stop()
    } else {
      this.next()
    }
  }

  /**
   * Calculate progress as 0..1
   */
  getProgress(): number {
    if (this.duration <= 0) return 0
    return this.currentTime / this.duration
  }
}
