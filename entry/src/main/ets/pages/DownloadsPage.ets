import { Colors, Dimensions } from '../common/Constants'
import { Song } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { SongListItem } from '../components/SongListItem'
import { MOCK_SONGS } from '../data/MockData'
import router from '@ohos.router'

@Entry
@Component
export struct DownloadsPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State downloadedSongs: Song[] = []
  @State editMode: boolean = false
  @State selectedIds: Set<string> = new Set()
  @State totalSize: string = ''

  aboutToAppear(): void {
    this.downloadedSongs = MOCK_SONGS.filter(s => s.isDownloaded)
    this.calculateTotalSize()
  }

  calculateTotalSize(): void {
    const totalMB = this.downloadedSongs.length * 8
    this.totalSize = totalMB > 1024 ?
      `${(totalMB / 1024).toFixed(1)} GB` :
      `${totalMB} MB`
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_chevron_left'))
          .width(24)
          .height(24)
          .onClick(() => { router.back() })

        Text('下载管理')
          .fontSize(Dimensions.fontSizeXL)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.textPrimary)
          .margin({ left: 8 })
          .layoutWeight(1)

        if (this.editMode) {
          Text('完成')
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.primary)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.editMode = false
              this.selectedIds.clear()
            })
        } else {
          Text('编辑')
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.primary)
            .onClick(() => { this.editMode = true })
        }

        if (this.editMode && this.selectedIds.size > 0) {
          Text('删除')
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.primary)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 12 })
            .onClick(() => {
              this.downloadedSongs = this.downloadedSongs.filter(s => !this.selectedIds.has(s.id))
              this.selectedIds.clear()
              this.editMode = false
              this.calculateTotalSize()
            })
        }
      }
      .width('100%')
      .padding({ left: 12, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 12, bottom: 12 })

      Row() {
        Text(`${this.downloadedSongs.length}首歌曲`)
          .fontSize(Dimensions.fontSizeSM)
          .fontColor(Colors.textSecondary)
        Text(' · ')
          .fontSize(Dimensions.fontSizeSM)
          .fontColor(Colors.textHint)
        Text(`共${this.totalSize}`)
          .fontSize(Dimensions.fontSizeSM)
          .fontColor(Colors.textSecondary)
        Blank()
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, bottom: 8 })

      Divider().strokeWidth(0.5).color(Colors.divider)

      if (this.downloadedSongs.length === 0) {
        Column() {
          Image($r('app.media.ic_downloads'))
            .width(48)
            .height(48)
            .fillColor(Colors.textHint)
            .opacity(0.4)
          Text('暂无下载歌曲')
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(Colors.textHint)
            .margin({ top: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        List() {
          ForEach(this.downloadedSongs, (song: Song, index: number) => {
            ListItem() {
              Row() {
                if (this.editMode) {
                  Checkbox({ name: song.id, group: 'downloads' })
                    .select(this.selectedIds.has(song.id))
                    .onChange((value: boolean) => {
                      if (value) {
                        this.selectedIds.add(song.id)
                      } else {
                        this.selectedIds.delete(song.id)
                      }
                    })
                    .margin({ right: 8 })
                }

                SongListItem({
                  song: song, showIndex: false, showCover: true,
                  onPlayClick: (s: Song) => {
                    if (!this.editMode) {
                      this.playerVM.playSong(s, this.downloadedSongs, index)
                      router.pushUrl({ url: 'pages/PlayerPage' })
                    }
                  }
                })
                .layoutWeight(1)
              }
              .padding({ left: Dimensions.horizontalPadding })
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
