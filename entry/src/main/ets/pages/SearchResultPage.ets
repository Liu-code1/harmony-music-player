import { Colors, Dimensions, SEARCH_CATEGORIES } from '../common/Constants'
import { Song } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { SongListItem } from '../components/SongListItem'
import { searchSongs } from '../data/MockData'
import router from '@ohos.router'

@Entry
@Component
export struct SearchResultPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State keyword: string = ''
  @State results: Song[] = []
  @State activeCategory: number = 0
  @State categories: string[] = SEARCH_CATEGORIES

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, Object>
    if (params && params['keyword']) {
      this.keyword = params['keyword'] as string
      this.results = searchSongs(this.keyword)
    }
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_chevron_left'))
          .width(24)
          .height(24)
          .onClick(() => { router.back() })

        Text(this.keyword)
          .fontSize(Dimensions.fontSizeLG)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.textPrimary)
          .margin({ left: 8 })
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .padding({ left: 12, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 8, bottom: 8 })

      Row() {
        ForEach(this.categories, (category: string, index: number) => {
          Text(category)
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(index === this.activeCategory ? Colors.primary : Colors.textSecondary)
            .fontWeight(index === this.activeCategory ? FontWeight.Medium : FontWeight.Normal)
            .padding({ left: 8, right: 8, top: 8, bottom: 8 })
            .onClick(() => { this.activeCategory = index })
        })
      }
      .width('100%')
      .padding({ left: 4 })

      Divider().strokeWidth(0.5).color(Colors.divider)

      if (this.results.length === 0) {
        Column() {
          Image($r('app.media.ic_music_note'))
            .width(48)
            .height(48)
            .fillColor(Colors.textHint)
            .opacity(0.4)
          Text(`未找到"${this.keyword}"的相关结果`)
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.textHint)
            .margin({ top: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Text(`找到 ${this.results.length} 首歌曲`)
          .fontSize(Dimensions.fontSizeSM)
          .fontColor(Colors.textSecondary)
          .padding({ left: Dimensions.horizontalPadding, top: 10, bottom: 6 })
          .alignSelf(ItemAlign.Start)

        List() {
          ForEach(this.results, (song: Song, index: number) => {
            ListItem() {
              SongListItem({
                song: song, showIndex: true, index: index, showCover: true,
                onPlayClick: (s: Song) => {
                  this.playerVM.playSong(s, this.results, index)
                  router.pushUrl({ url: 'pages/PlayerPage' })
                }
              })
            }
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
