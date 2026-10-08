import { Colors, Dimensions } from '../common/Constants'
import { formatTime } from '../data/MockData'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'

@Component
export struct MiniPlayer {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  onOpenPlayer?: () => void = undefined

  build() {
    if (this.playerVM.currentSong && this.playerVM.showPlayer) {
      Column() {
        Row() {
          // Album cover image
          Image($r('app.media.cover_default'))
            .width(40)
            .height(40)
            .borderRadius(6)
            .margin({ right: 10 })
            .objectFit(ImageFit.Cover)

          // Song info
          Column() {
            Text(this.playerVM.currentSong?.name || '')
              .fontSize(Dimensions.fontSizeMD)
              .fontColor(Colors.textPrimary)
              .fontWeight(FontWeight.Medium)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(this.playerVM.currentSong?.artist || '')
              .fontSize(Dimensions.fontSizeXS)
              .fontColor(Colors.textSecondary)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // Progress
          Text(formatTime(this.playerVM.currentTime))
            .fontSize(Dimensions.fontSizeXS)
            .fontColor(Colors.textSecondary)
            .margin({ right: 8 })

          // Play/Pause
          Image(this.playerVM.isPlaying ?
            $r('app.media.ic_pause') : $r('app.media.ic_play'))
            .width(28)
            .height(28)
            .onClick(() => {
              this.playerVM.togglePlay()
            })

          // Next
          Image($r('app.media.ic_next'))
            .width(22)
            .height(22)
            .margin({ left: 8 })
            .onClick(() => {
              this.playerVM.next()
            })
        }
        .width('100%')
        .height(Dimensions.miniPlayerHeight - 4)
        .padding({ left: 12, right: 12 })

        // Progress bar
        if (this.playerVM.duration > 0) {
          Row()
            .width(`${this.playerVM.getProgress() * 100}%`)
            .height(2)
            .backgroundColor(Colors.primary)
            .borderRadius(1)
        }
      }
      .width('100%')
      .backgroundColor(Colors.cardBackground)
      .onClick(() => {
        if (this.onOpenPlayer) {
          this.onOpenPlayer()
        }
      })
      .shadow({ radius: 8, color: '#10000000', offsetY: -2 })
    }
  }
}
