import { Colors, Dimensions } from '../common/Constants'

@Component
export struct SearchBar {
  @Prop placeholder: string = '搜索歌曲、歌手、专辑...'
  @Link value: string
  autoFocus: boolean = true
  onChange?: (value: string) => void = undefined
  onSubmit?: (value: string) => void = undefined
  onClear?: () => void = undefined

  build() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(Dimensions.iconMedium)
        .height(Dimensions.iconMedium)
        .fillColor(Colors.textSecondary)
        .margin({ left: 12, right: 8 })

      TextInput({ placeholder: this.placeholder, text: this.value })
        .layoutWeight(1)
        .height(40)
        .fontSize(Dimensions.fontSizeMD)
        .backgroundColor(Color.Transparent)
        .border({ width: 0 })
        .onChange((value: string) => {
          this.value = value
          if (this.onChange) {
            this.onChange(value)
          }
        })
        .onSubmit((enterKey: EnterKeyType) => {
          if (this.onSubmit) {
            this.onSubmit(this.value)
          }
        })

      if (this.value && this.value.length > 0) {
        Image($r('app.media.ic_clear'))
          .width(Dimensions.iconSmall + 2)
          .height(Dimensions.iconSmall + 2)
          .margin({ right: 12 })
          .onClick(() => {
            this.value = ''
            if (this.onClear) {
              this.onClear()
            }
          })
      }
    }
    .width('100%')
    .height(44)
    .backgroundColor('#F0F0F2')
    .borderRadius(22)
  }
}
