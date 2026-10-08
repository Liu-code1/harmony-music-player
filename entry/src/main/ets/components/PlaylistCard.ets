import { Playlist } from '../model/PlaylistModel'
import { Colors, Dimensions } from '../common/Constants'
import { formatPlayCount } from '../data/MockData'

@Component
export struct PlaylistCard {
  @Prop playlist: Playlist = {} as Playlist
  @Prop cardSize: string = 'small'

  build() {
    Column() {
      // Cover image section
      Stack() {
        Image(this.getCoverResource())
          .width('100%')
          .aspectRatio(1)
          .borderRadius(Dimensions.borderRadius)
          .objectFit(ImageFit.Cover)

        // Play count at top-right
        if (this.playlist.playCount > 0) {
          Row() {
            Image($r('app.media.ic_play_all'))
              .width(8)
              .height(8)
              .fillColor(Color.White)
            Text(formatPlayCount(this.playlist.playCount))
              .fontSize(10)
              .fontColor(Color.White)
              .margin({ left: 2 })
          }
          .backgroundColor('rgba(0,0,0,0.4)')
          .borderRadius(8)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .position({ x: '100%', y: 0 })
          .translate({ x: '-100%', y: 6 })
          .offset({ x: -4, y: 4 })
        }

        // Song count badge
        if (this.playlist.songCount > 0) {
          Text(`${this.playlist.songCount}首`)
            .fontSize(10)
            .fontColor(Color.White)
            .backgroundColor('rgba(0,0,0,0.5)')
            .borderRadius(4)
            .padding({ left: 4, right: 4, top: 1, bottom: 1 })
            .position({ x: 4, y: '100%' })
            .translate({ x: 0, y: '-100%' })
            .offset({ x: 0, y: -4 })
        }
      }
      .width(this.cardSize === 'large' ? 160 : Dimensions.playlistCoverSize as number)

      // Text section
      Column() {
        // Name
        Text(this.playlist.name || '未知歌单')
          .fontSize(this.cardSize === 'large' ? Dimensions.fontSizeMD : Dimensions.fontSizeSM)
          .fontColor(Colors.textPrimary)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(this.cardSize === 'large' ? 20 : 16)

        // Description
        if (this.playlist.description && this.cardSize === 'large') {
          Text(this.playlist.description)
            .fontSize(Dimensions.fontSizeXS)
            .fontColor(Colors.textSecondary)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 4 })
        }
      }
      .width('100%')
      .padding({ top: 8 })
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
  }

  private getCoverResource(): Resource {
    const index = parseInt(this.playlist.id.replace(/[^0-9]/g, '')) || 1
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
