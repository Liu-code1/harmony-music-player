import { Colors, Dimensions } from '../common/Constants'

@Component
export struct SectionHeader {
  @Prop title: string = ''
  @Prop showMore: boolean = false
  onMoreClick?: () => void = undefined

  build() {
    Row() {
      Text(this.title)
        .fontSize(Dimensions.fontSizeXL)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.textPrimary)

      Blank()

      if (this.showMore) {
        Row() {
          Text('查看更多')
            .fontSize(Dimensions.fontSizeSM)
            .fontColor(Colors.textSecondary)
          Text('›')
            .fontSize(Dimensions.fontSizeLG)
            .fontColor(Colors.textSecondary)
            .margin({ left: 2 })
        }
        .onClick(() => {
          if (this.onMoreClick) {
            this.onMoreClick()
          }
        })
      }
    }
    .width('100%')
    .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })
    .margin({ top: 20, bottom: 10 })
  }
}
