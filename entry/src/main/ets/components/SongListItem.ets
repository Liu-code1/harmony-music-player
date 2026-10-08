import { Song } from '../model/SongModel'
import { Colors, Dimensions } from '../common/Constants'
import { formatTime } from '../data/MockData'

@Component
export struct SongListItem {
  @Prop song: Song = {} as Song
  @Prop showIndex: boolean = false
  @Prop index: number = 0
  @Prop showCover: boolean = true
  onPlayClick?: (song: Song) => void = undefined

  build() {
    Column() {
      if (this.song) {
        Row() {
          if (this.showIndex) {
            Text(`${this.index + 1}`)
              .fontSize(Dimensions.fontSizeLG)
              .fontColor(this.index < 3 ? Colors.primary : Colors.textSecondary)
              .fontWeight(this.index < 3 ? FontWeight.Bold : FontWeight.Normal)
              .width(28)
              .textAlign(TextAlign.Center)
          }

          if (this.showCover) {
            Image(this.getCoverResource())
              .width(44)
              .height(44)
              .borderRadius(6)
              .margin({ left: this.showIndex ? 8 : 0, right: 10 })
              .objectFit(ImageFit.Cover)
          }

          Column() {
            Text(this.song.name || '未知歌曲')
              .fontSize(Dimensions.fontSizeMD)
              .fontColor(Colors.textPrimary)
              .fontWeight(FontWeight.Medium)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Text(`${this.song.artist || '未知艺术家'} - ${this.song.album || '未知专辑'}`)
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          if (this.song.isLiked) {
            Image($r('app.media.ic_like_filled'))
              .width(14)
              .height(14)
              .fillColor(Colors.likeActive)
              .margin({ right: 8 })
          }

          if (this.song.duration && this.song.duration > 0) {
            Text(formatTime(this.song.duration))
              .fontSize(Dimensions.fontSizeXS)
              .fontColor(Colors.textHint)
              .margin({ right: 4 })
          }
        }
        .width('100%')
        .padding({ left: 12, right: 16, top: 10, bottom: 10 })
        .onClick(() => {
          if (this.onPlayClick && this.song) {
            this.onPlayClick(this.song)
          }
        })
      }
    }
  }

  private getCoverResource(): Resource {
    const index = parseInt(this.song.id.replace('s', '')) || 1
    const resources: Resource[] = [
      $r('app.media.1'), $r('app.media.2'), $r('app.media.3'), $r('app.media.4'),
      $r('app.media.5'), $r('app.media.6'), $r('app.media.7'), $r('app.media.8'),
      $r('app.media.9'), $r('app.media.10'), $r('app.media.11'), $r('app.media.12'),
      $r('app.media.13'), $r('app.media.14'), $r('app.media.15'), $r('app.media.16'),
      $r('app.media.17'), $r('app.media.18'), $r('app.media.19'), $r('app.media.20'),
      $r('app.media.21'), $r('app.media.22'), $r('app.media.23'), $r('app.media.24'),
      $r('app.media.25'), $r('app.media.26'), $r('app.media.27'), $r('app.media.28'),
      $r('app.media.29'), $r('app.media.30'), $r('app.media.31'), $r('app.media.32'),
      $r('app.media.33'), $r('app.media.34'), $r('app.media.35'), $r('app.media.36'),
      $r('app.media.37'), $r('app.media.38'), $r('app.media.39'), $r('app.media.40'),
    ]
    return resources[(index - 1) % resources.length]
  }
}
