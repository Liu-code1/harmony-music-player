import { Colors, Dimensions, getPlayModeLabel, getPlayModeIconResource } from '../common/Constants'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { PlayControlBar } from '../components/PlayControlBar'
import { LyricView } from '../components/LyricView'
import { MOCK_LYRICS, formatTime } from '../data/MockData'
import { LyricLine } from '../model/SongModel'
import router from '@ohos.router'

@Entry
@Component
export struct PlayerPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State showLyrics: boolean = false
  @State lyrics: LyricLine[] = []
  @State albumRotate: number = 0

  aboutToAppear(): void {
    if (this.playerVM.currentSong) {
      this.loadLyrics()
    }
  }

  loadLyrics(): void {
    const songId = this.playerVM.currentSong?.id
    if (songId && MOCK_LYRICS[songId]) {
      this.lyrics = MOCK_LYRICS[songId]
    } else {
      this.lyrics = []
    }
  }

  build() {
    Column() {
      // ---- Top bar ----
      Row() {
        Image($r('app.media.ic_chevron_down'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor(Color.White)
          .onClick(() => {
            router.back()
          })

        Blank()

        Column() {
          Text(this.playerVM.currentSong?.name || '未知歌曲')
            .fontSize(Dimensions.fontSizeLG)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(this.playerVM.currentSong?.artist || '未知艺术家')
            .fontSize(Dimensions.fontSizeXS)
            .fontColor('#AAFFFFFF')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Blank()

        Image($r('app.media.ic_share'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor(Color.White)
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 12, bottom: 8 })

      // ---- Album art + lyrics toggle area ----
      if (!this.showLyrics) {
        Column() {
          Stack() {
            // Large album art with rotation animation
            Image($r('app.media.cover_default'))
              .width(240)
              .height(240)
              .borderRadius(120)
              .objectFit(ImageFit.Cover)
              .shadow({ radius: 30, color: '#40000000' })
              .rotate({ angle: this.albumRotate })
              .animation({
                duration: 8000,
                curve: Curve.Linear,
                iterations: -1
              })

            // Inner circle (vinyl record)
            Image($r('app.media.ic_music_note'))
              .width(80)
              .height(80)
              .borderRadius(40)
              .backgroundColor('#AA000000')
          }
          .width(240)
          .height(240)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.showLyrics = true
        })
      } else {
        LyricView({
          lyrics: this.lyrics,
          currentTime: this.playerVM.currentTime,
          collapsed: false
        })
        .layoutWeight(1)
        .onClick(() => {
          this.showLyrics = false
        })
      }

      // ---- Progress bar ----
      Column() {
        Slider({
          value: this.playerVM.getProgress() * 100,
          min: 0,
          max: 100,
          step: 0.1
        })
        .width('100%')
        .blockSize({ width: 14, height: 14 })
        .trackColor('#40FFFFFF')
        .selectedColor(Color.White)
        .blockColor(Color.White)
        .onChange((value: number) => {
          const time = (value / 100) * this.playerVM.duration
          this.playerVM.seekTo(time)
        })

        Row() {
          Text(formatTime(this.playerVM.currentTime))
            .fontSize(Dimensions.fontSizeXS)
            .fontColor('#AAFFFFFF')

          Blank()

          Text(formatTime(this.playerVM.duration))
            .fontSize(Dimensions.fontSizeXS)
            .fontColor('#AAFFFFFF')
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

      // ---- Play control bar ----
      PlayControlBar({
        isPlaying: this.playerVM.isPlaying,
        onTogglePlay: () => { this.playerVM.togglePlay() },
        onPrev: () => {
          this.playerVM.prev()
          this.loadLyrics()
        },
        onNext: () => {
          this.playerVM.next()
          this.loadLyrics()
        }
      })
      .margin({ top: 8, bottom: 4 })

      // ---- Bottom action row ----
      Row() {
        // Play mode
        Column() {
          Image(getPlayModeIconResource(this.playerVM.playMode))
            .width(Dimensions.iconSmall)
            .height(Dimensions.iconSmall)
            .fillColor('#AAFFFFFF')
          Text(getPlayModeLabel(this.playerVM.playMode))
            .fontSize(8)
            .fontColor('#80FFFFFF')
            .margin({ top: 2 })
        }
        .onClick(() => { this.playerVM.togglePlayMode() })

        Blank()

        // Like button
        Image(this.playerVM.isLiked ?
          $r('app.media.ic_like_filled') : $r('app.media.ic_like'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor(this.playerVM.isLiked ? Colors.likeActive : '#AAFFFFFF')
          .onClick(() => { this.playerVM.toggleLike() })

        Blank()

        // Download
        Image($r('app.media.ic_download'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor('#AAFFFFFF')

        Blank()

        // Comments
        Image($r('app.media.ic_comment'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor('#AAFFFFFF')

        Blank()

        // Share
        Image($r('app.media.ic_share'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor('#AAFFFFFF')

        Blank()

        // More
        Image($r('app.media.ic_more'))
          .width(Dimensions.iconMedium)
          .height(Dimensions.iconMedium)
          .fillColor('#AAFFFFFF')
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#1a1a2e', 0.0],
        ['#16213e', 0.4],
        ['#0f3460', 0.8],
        ['#1C1C1E', 1.0]
      ]
    })
  }

  aboutToDisappear(): void {
    // Keep playing when navigating away
  }
}
