import { Song } from '../model/SongModel'
import media from '@ohos.multimedia.media'

export class AudioPlayer {
  private static instance: AudioPlayer
  private currentSong: Song | null = null
  private isPlaying: boolean = false
  private currentTime: number = 0
  private duration: number = 0
  private progressTimer: number = -1
  private avPlayer: media.AVPlayer | null = null

  private onProgressCallback: ((time: number) => void) | null = null
  private onCompleteCallback: (() => void) | null = null

  static getInstance(): AudioPlayer {
    if (!AudioPlayer.instance) {
      AudioPlayer.instance = new AudioPlayer()
    }
    return AudioPlayer.instance
  }

  private constructor() {}

  async play(song: Song): Promise<void> {
    if (!song || !song.sourceUrl) {
      console.warn('AudioPlayer.play: song or sourceUrl is null')
      return
    }

    this.currentSong = song
    this.duration = song.duration || 240000
    this.isPlaying = true
    this.currentTime = 0

    try {
      if (this.avPlayer) {
        await this.avPlayer.stop()
        this.avPlayer.release()
        this.avPlayer = null
      }

      this.avPlayer = await new Promise<media.AVPlayer>((resolve, reject) => {
        media.createAVPlayer((err, player) => {
          if (err) {
            reject(err)
          } else {
            resolve(player)
          }
        })
      })

      this.avPlayer.on('error', (err: Error) => {
        console.error('AudioPlayer error: ' + err.message)
        this.startProgressSimulation()
      })

      this.avPlayer.on('timeUpdate', () => {
        if (this.avPlayer && this.onProgressCallback) {
          this.currentTime = Math.floor(this.avPlayer.currentTime * 1000)
          this.onProgressCallback(this.currentTime)
        }
      })

      this.avPlayer.url = song.sourceUrl
      await this.avPlayer.prepare()
      await this.avPlayer.play()

      if (this.avPlayer.duration) {
        this.duration = Math.floor(this.avPlayer.duration * 1000)
      }

      console.info(`Playing song: ${song.name}`)
    } catch (e) {
      console.error('AudioPlayer.play error: ' + e)
      this.startProgressSimulation()
    }
  }

  resume(): void {
    if (this.currentSong && this.avPlayer) {
      this.isPlaying = true
      this.avPlayer.play().catch(() => {
        this.startProgressSimulation()
      })
    }
  }

  pause(): void {
    this.isPlaying = false
    if (this.avPlayer) {
      this.avPlayer.pause().catch(() => {})
    }
    this.stopProgressSimulation()
  }

  stop(): void {
    this.isPlaying = false
    this.currentTime = 0
    if (this.avPlayer) {
      this.avPlayer.stop().catch(() => {})
      this.avPlayer.release().catch(() => {})
      this.avPlayer = null
    }
    this.stopProgressSimulation()
    this.currentSong = null
    this.duration = 0
  }

  seek(time: number): void {
    this.currentTime = Math.max(0, Math.min(time, this.duration))
    if (this.avPlayer) {
      this.avPlayer.seek(time / 1000)
    }
    if (this.onProgressCallback) {
      this.onProgressCallback(this.currentTime)
    }
  }

  setOnProgress(callback: (time: number) => void): void {
    this.onProgressCallback = callback
  }

  setOnComplete(callback: () => void): void {
    this.onCompleteCallback = callback
  }

  getCurrentTime(): number {
    return this.currentTime
  }

  getDuration(): number {
    return this.duration
  }

  getIsPlaying(): boolean {
    return this.isPlaying
  }

  getCurrentSong(): Song | null {
    return this.currentSong
  }

  private startProgressSimulation(): void {
    if (this.progressTimer >= 0) {
      clearInterval(this.progressTimer)
    }
    this.progressTimer = setInterval(() => {
      if (this.isPlaying) {
        this.currentTime += 1000
        if (this.currentTime >= this.duration) {
          this.currentTime = this.duration
          this.isPlaying = false
          this.stopProgressSimulation()
          if (this.onCompleteCallback) {
            this.onCompleteCallback()
          }
        }
        if (this.onProgressCallback) {
          this.onProgressCallback(this.currentTime)
        }
      }
    }, 1000)
  }

  private stopProgressSimulation(): void {
    if (this.progressTimer >= 0) {
      clearInterval(this.progressTimer)
      this.progressTimer = -1
    }
  }

  destroy(): void {
    this.stop()
  }
}
