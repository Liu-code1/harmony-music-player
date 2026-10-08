import { LyricLine } from '../model/SongModel'
import { Colors, Dimensions } from '../common/Constants'

@Component
export struct LyricView {
  @Prop lyrics: LyricLine[] = []
  @Prop currentTime: number = 0
  @Prop collapsed: boolean = false

  private scroller: Scroller = new Scroller()

  private getCurrentLineIndex(): number {
    if (this.lyrics.length === 0) return -1
    let idx = 0
    for (let i = 0; i < this.lyrics.length; i++) {
      if (this.lyrics[i].time <= this.currentTime) {
        idx = i
      } else {
        break
      }
    }
    return idx
  }

  build() {
    Column() {
      if (this.lyrics.length === 0) {
        Image($r('app.media.ic_music_note'))
          .width(48)
          .height(48)
          .fillColor(Colors.textHint)
          .opacity(0.4)
          .margin({ top: 40 })
        Text('暂无歌词')
          .fontSize(Dimensions.fontSizeMD)
          .fontColor(Colors.textHint)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 12 })
      } else {
        List({ scroller: this.scroller }) {
          ListItem() {
            Row().height('40%')
          }

          ForEach(this.lyrics, (line: LyricLine, index: number) => {
            ListItem() {
              Text(line.text)
                .fontSize(this.getCurrentLineIndex() === index ?
                  Dimensions.fontSizeLG : Dimensions.fontSizeMD)
                .fontColor(this.getCurrentLineIndex() === index ?
                  Colors.primary : Colors.textSecondary)
                .fontWeight(this.getCurrentLineIndex() === index ?
                  FontWeight.Medium : FontWeight.Normal)
                .width('100%')
                .textAlign(TextAlign.Center)
                .padding({ top: 8, bottom: 8 })
                .animation({ duration: 300, curve: Curve.EaseInOut })
            }
          })

          ListItem() {
            Row().height('60%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
    }
    .width('100%')
    .height(this.collapsed ? 0 : '100%')
  }
}
