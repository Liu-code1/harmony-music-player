import { Colors, Dimensions, getTabItems, TabItem } from '../common/Constants'

@Component
export struct TabBar {
  @Prop currentTab: number = 0
  onTabChange?: (index: number) => void = undefined

  build() {
    Row() {
      ForEach(getTabItems(), (item: TabItem, index: number) => {
        Column() {
          Image(index === this.currentTab ? item.iconActive : item.icon)
            .width(22)
            .height(22)
          Text(item.name)
            .fontSize(Dimensions.fontSizeXS)
            .fontWeight(index === this.currentTab ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(index === this.currentTab ? Colors.tabActive : Colors.tabInactive)
            .margin({ top: 2 })
        }
        .width('25%')
        .height(Dimensions.tabBarHeight - 8)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          if (this.onTabChange) {
            this.onTabChange(index)
          }
        })
      })
    }
    .width('100%')
    .height(Dimensions.tabBarHeight)
    .backgroundColor(Colors.cardBackground)
    .padding({ bottom: 4 })
  }
}
