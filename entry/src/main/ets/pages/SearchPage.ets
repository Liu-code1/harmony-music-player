import { Colors, Dimensions } from '../common/Constants'
import { HotSearch } from '../model/SearchModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { SearchBar } from '../components/SearchBar'
import { MOCK_HOT_SEARCHES, getSearchSuggestions, searchSongs } from '../data/MockData'
import { Song } from '../model/SongModel'
import { SongListItem } from '../components/SongListItem'
import router from '@ohos.router'

@Entry
@Component
export struct SearchPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State searchValue: string = ''
  @State hotSearches: HotSearch[] = MOCK_HOT_SEARCHES
  @State historyList: string[] = ['红线', 'Good Things', '这一刻我写下这首歌', '周杰伦', '晴天']
  @State suggestions: string[] = []
  @State showResults: boolean = false
  @State searchResults: Song[] = []
  @State activeCategory: number = 0
  private categories: string[] = ['歌手', '曲风', '专区', '识曲']

  build() {
    Column() {
      // ---- Top bar: SearchBar + mic + 搜索 ----
      Row() {
        SearchBar({
          value: $searchValue,
          placeholder: '搜索歌曲、歌手、专辑...',
          onChange: (value: string) => { this.onSearchChange(value) },
          onSubmit: (value: string) => { this.onSearchSubmit(value) },
          onClear: () => { this.onSearchClear() }
        })
        .layoutWeight(1)

        // Mic icon
        Image($r('app.media.ic_search'))
          .width(22)
          .height(22)
          .fillColor(Colors.textPrimary)
          .margin({ left: 10, right: 6 })

        // 搜索 text button
        Text('搜索')
          .fontSize(Dimensions.fontSizeMD)
          .fontColor(Colors.textPrimary)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            if (this.searchValue.trim().length > 0) {
              this.onSearchSubmit(this.searchValue)
            }
          })
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 8, bottom: 4 })

      // ---- Category tab bar (平均分布) ----
      Row() {
        ForEach(this.categories, (category: string, index: number) => {
          Column() {
            Text(category)
              .fontSize(Dimensions.fontSizeLG)
              .fontWeight(index === this.activeCategory ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(index === this.activeCategory ? Colors.textPrimary : Colors.textSecondary)
              .padding({ top: 8, bottom: 6 })

            // Underline indicator for selected tab
            if (index === this.activeCategory) {
              Divider()
                .strokeWidth(2.5)
                .width(24)
                .color(Colors.primary)
            } else {
              Divider()
                .strokeWidth(0)
                .width(24)
                .color(Color.Transparent)
            }
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => { this.activeCategory = index })
        })
      }
      .width('100%')
      .padding({ left: 0, right: 0 })

      Divider().strokeWidth(0.5).color(Colors.divider)

      // ---- Content area ----
      if (this.showResults) {
        this.SearchResultsView()
      } else if (this.searchValue.length > 0 && this.suggestions.length > 0) {
        this.SuggestionsView()
      } else {
        this.DefaultView()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  DefaultView() {
    Scroll() {
      Column() {
        // ---- Search history section ----
        if (this.historyList.length > 0) {
          // Section title
          Row() {
            Image($r('app.media.ic_search'))
              .width(Dimensions.fontSizeMD)
              .height(Dimensions.fontSizeMD)
              .fillColor(Colors.textPrimary)
              .margin({ right: 6 })

            Text('搜索历史')
              .fontSize(Dimensions.fontSizeXL)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.textPrimary)
              .layoutWeight(1)

            Image($r('app.media.ic_clear'))
              .width(Dimensions.fontSizeMD)
              .height(Dimensions.fontSizeMD)
              .fillColor(Colors.textHint)
              .onClick(() => { this.historyList = [] })
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 16, bottom: 10 })

          // History terms — horizontal flow wrap layout
          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.historyList, (term: string, index: number) => {
              Row() {
                Text(term)
                  .fontSize(Dimensions.fontSizeSM)
                  .fontColor(Colors.textSecondary)
                  .maxLines(1)

                Image($r('app.media.ic_clear'))
                  .width(12)
                  .height(12)
                  .fillColor(Colors.textHint)
                  .margin({ left: 6 })
                  .onClick(() => {
                    this.historyList.splice(index, 1)
                  })
              }
              .backgroundColor('#F0F0F2')
              .borderRadius(16)
              .padding({ left: 14, right: 10, top: 8, bottom: 8 })
              .margin({ right: 10, bottom: 10 })
              .onClick(() => {
                this.searchValue = term
                this.onSearchSubmit(term)
              })
            })
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 6 })
        }

        // ---- Hot search section (保持现状) ----
        if (this.hotSearches.length > 0) {
          Row() {
            Image($r('app.media.ic_search'))
              .width(Dimensions.fontSizeMD)
              .height(Dimensions.fontSizeMD)
              .fillColor(Colors.primary)
              .margin({ right: 6 })

            Text('热搜榜')
              .fontSize(Dimensions.fontSizeXL)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.textPrimary)
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 24, bottom: 10 })

          ForEach(this.hotSearches, (item: HotSearch, index: number) => {
            Row() {
              Text(`${index + 1}`)
                .fontSize(Dimensions.fontSizeLG)
                .fontColor(index < 3 ? Colors.primary : Colors.textSecondary)
                .fontWeight(index < 3 ? FontWeight.Bold : FontWeight.Normal)
                .width(24)
                .textAlign(TextAlign.Center)

              Column() {
                Text(item.keyword)
                  .fontSize(Dimensions.fontSizeMD)
                  .fontColor(Colors.textPrimary)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .layoutWeight(1)

              if (item.tag) {
                Text(item.tag)
                  .fontSize(10)
                  .fontColor(Color.White)
                  .backgroundColor(item.tag === '爆' ? Colors.primary : Colors.primaryLight)
                  .borderRadius(4)
                  .padding({ left: 4, right: 4, top: 1, bottom: 1 })
              }

              Text(`${(item.searchCount / 10000).toFixed(0)}万`)
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textHint)
                .margin({ left: 8 })
            }
            .width('100%')
            .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 10, bottom: 10 })
            .onClick(() => {
              this.searchValue = item.keyword
              this.onSearchSubmit(item.keyword)
            })
          })
        }

        Row().height(80)
      }
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }

  @Builder
  SuggestionsView() {
    Column() {
      ForEach(this.suggestions, (suggestion: string) => {
        Row() {
          Image($r('app.media.ic_search'))
            .width(Dimensions.fontSizeSM)
            .height(Dimensions.fontSizeSM)
            .fillColor(Colors.textHint)
            .margin({ right: 10 })
          Text(suggestion)
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.textPrimary)
            .layoutWeight(1)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .width('100%')
        .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 14, bottom: 14 })
        .onClick(() => {
          this.searchValue = suggestion
          this.onSearchSubmit(suggestion)
        })
      })
    }
    .layoutWeight(1)
  }

  @Builder
  SearchResultsView() {
    List() {
      ForEach(this.searchResults, (song: Song, index: number) => {
        ListItem() {
          SongListItem({
            song: song, showIndex: true, index: index, showCover: true,
            onPlayClick: (s: Song) => { this.playerVM.playSong(s, this.searchResults, index) }
          })
        }
      })
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  private onSearchChange(value: string): void {
    if (value.length > 0) {
      this.suggestions = getSearchSuggestions(value)
      this.showResults = false
    } else {
      this.suggestions = []
      this.showResults = false
    }
  }

  private onSearchSubmit(value: string): void {
    if (value.trim().length === 0) return
    if (!this.historyList.includes(value)) {
      this.historyList = [value, ...this.historyList].slice(0, 15)
    }
    this.searchResults = searchSongs(value)
    this.showResults = true
    this.suggestions = []
  }

  private onSearchClear(): void {
    this.searchValue = ''
    this.showResults = false
    this.suggestions = []
    this.searchResults = []
  }
}
