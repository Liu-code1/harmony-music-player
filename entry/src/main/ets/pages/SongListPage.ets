import { Colors, Dimensions } from '../common/Constants'
import { Song } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { SongListItem } from '../components/SongListItem'
import { MOCK_SONGS } from '../data/MockData'
import router from '@ohos.router'

@Entry
@Component
export struct SongListPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State songs: Song[] = []
  @State title: string = '歌曲列表'

  aboutToAppear(): void {
    try {
      const params = router.getParams() as Record<string, Object>
      if (params) {
        if (typeof params['title'] === 'string') {
          this.title = params['title'] as string
        }
        if (Array.isArray(params['songs'])) {
          this.songs = params['songs'] as Song[]
        } else if (typeof params['chartId'] === 'string') {
          this.songs = MOCK_SONGS
        }
      }
    } catch (e) {
      console.error('SongListPage.aboutToAppear error:', e)
    }
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_chevron_left'))
          .width(24)
          .height(24)
          .onClick(() => { router.back() })

        Text(this.title)
          .fontSize(Dimensions.fontSizeXL)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.textPrimary)
          .margin({ left: 8 })
          .layoutWeight(1)

        Row() {
          Image($r('app.media.ic_play_all'))
            .width(Dimensions.fontSizeSM)
            .height(Dimensions.fontSizeSM)
            .fillColor(Colors.primary)
            .margin({ right: 4 })
          Text('播放全部')
            .fontSize(Dimensions.fontSizeSM)
            .fontColor(Colors.primary)
        }
        .onClick(() => {
          if (this.songs.length > 0) {
            this.playerVM.playSong(this.songs[0], this.songs, 0)
            router.pushUrl({ url: 'pages/PlayerPage' })
          }
        })
      }
      .width('100%')
      .padding({ left: 12, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 12, bottom: 12 })

      Divider().strokeWidth(0.5).color(Colors.divider)

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
