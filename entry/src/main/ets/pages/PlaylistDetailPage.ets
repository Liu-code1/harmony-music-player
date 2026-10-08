import { Colors, Dimensions } from '../common/Constants'
import { Playlist } from '../model/PlaylistModel'
import { Song } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { SongListItem } from '../components/SongListItem'
import { getPlaylistById, formatPlayCount } from '../data/MockData'
import router from '@ohos.router'

@Entry
@Component
export struct PlaylistDetailPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State playlist: Playlist | null = null
  @State songs: Song[] = []
  private playlistId: string = ''

  aboutToAppear(): void {
    try {
      const params = router.getParams() as Record<string, Object>
      if (params && typeof params['playlistId'] === 'string') {
        this.playlistId = params['playlistId'] as string
        const found = getPlaylistById(this.playlistId)
        if (found) {
          this.playlist = found
          this.songs = found.songs || []
        }
      }
    } catch (e) {
      console.error('PlaylistDetailPage.aboutToAppear error:', e)
    }
  }

  build() {
    if (!this.playlist) {
      Column() {
        Text('加载中...')
          .fontSize(Dimensions.fontSizeMD)
          .fontColor(Colors.textHint)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    } else {
      Column() {
        // ---- Header ----
        Row() {
          Image(this.getCoverResource())
            .width(120)
            .height(120)
            .borderRadius(Dimensions.borderRadius)
            .objectFit(ImageFit.Cover)

          Column() {
            Text(this.playlist!.name)
              .fontSize(Dimensions.fontSizeXL)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.textPrimary)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            if (this.playlist!.creator) {
              Text(`by ${this.playlist!.creator}`)
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Colors.textSecondary)
                .margin({ top: 4 })
            }

            Row() {
              Text(`${formatPlayCount(this.playlist!.playCount)}次播放`)
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textHint)
              Text(' · ')
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textHint)
              Text(`${this.playlist!.songCount}首`)
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textHint)
            }
            .margin({ top: 4 })

            if (this.playlist!.description) {
              Text(this.playlist!.description)
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textSecondary)
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: 6 })
            }
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 16, bottom: 16 })

        // ---- Play all button ----
        Row() {
          Image($r('app.media.ic_play_all'))
            .width(Dimensions.fontSizeLG)
            .height(Dimensions.fontSizeLG)
            .fillColor(Color.White)
            .margin({ right: 8 })
          Text('播放全部')
            .fontSize(Dimensions.fontSizeLG)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .width('100%')
        .height(44)
        .backgroundColor(Colors.primary)
        .borderRadius(22)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, bottom: 12 })
        .onClick(() => {
          if (this.songs.length > 0) {
            this.playerVM.playSong(this.songs[0], this.songs, 0)
            router.pushUrl({ url: 'pages/PlayerPage' })
          }
        })

        // Tags
        if (this.playlist!.tags && this.playlist!.tags.length > 0) {
          Row() {
            ForEach(this.playlist!.tags, (tag: string) => {
              Text(`#${tag}`)
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.primary)
                .backgroundColor(Colors.primary + '15')
                .borderRadius(10)
                .padding({ left: 8, right: 8, top: 3, bottom: 3 })
                .margin({ right: 8 })
            })
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, bottom: 10 })
        }

        Divider().strokeWidth(0.5).color(Colors.divider)

        // ---- Song list ----
        List() {
          ForEach(this.songs, (song: Song, index: number) => {
            ListItem() {
              SongListItem({
                song: song, showIndex: true, index: index, showCover: true,
                onPlayClick: (s: Song) => {
                  this.playerVM.playSong(s, this.songs, index)
                  router.pushUrl({ url: 'pages/PlayerPage' })
                }
              })
            }
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)
    }
  }

  private getCoverResource(): Resource {
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
    const idx = parseInt(this.playlistId.replace(/[^0-9]/g, '')) || 1
    return resources[(idx - 1) % resources.length]
  }
}
