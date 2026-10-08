import { Colors, Dimensions } from '../common/Constants'
import router from '@ohos.router'

@Entry
@Component
export struct SettingsPage {
  @State themeMode: string = '跟随系统'
  @State cacheSize: string = '128.5 MB'
  @State appVersion: string = '1.0.0'
  @State showLogoutDialog: boolean = false

  build() {
    Stack() {
      Column() {
        Row() {
          Image($r('app.media.ic_chevron_left'))
            .width(24)
            .height(24)
            .onClick(() => { router.back() })

          Text('设置')
            .fontSize(Dimensions.fontSizeXL)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.textPrimary)
            .margin({ left: 8 })
            .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 12, right: Dimensions.horizontalPadding, top: Dimensions.statusBarHeight + 12, bottom: 12 })

        Scroll() {
          Column() {
            // ---- Account ----
            Text('账号管理')
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .padding({ left: Dimensions.horizontalPadding, top: 20, bottom: 8 })
              .alignSelf(ItemAlign.Start)

            Column() {
              this.SettingRow('个人资料', '›', () => {})
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('账号安全', '›', () => {})
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('隐私设置', '›', () => {})
            }
            .backgroundColor(Colors.cardBackground)
            .borderRadius(Dimensions.borderRadius)
            .margin({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

            // ---- Display ----
            Text('显示与外观')
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .padding({ left: Dimensions.horizontalPadding, top: 20, bottom: 8 })
              .alignSelf(ItemAlign.Start)

            Column() {
              this.SettingRow('主题切换', this.themeMode, () => { this.cycleTheme() })
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('音质偏好', '标准', () => {})
            }
            .backgroundColor(Colors.cardBackground)
            .borderRadius(Dimensions.borderRadius)
            .margin({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

            // ---- Storage ----
            Text('存储与缓存')
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .padding({ left: Dimensions.horizontalPadding, top: 20, bottom: 8 })
              .alignSelf(ItemAlign.Start)

            Column() {
              this.SettingRow('清理缓存', this.cacheSize, () => { this.cacheSize = '0 B' })
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('下载位置', '本地存储', () => {})
            }
            .backgroundColor(Colors.cardBackground)
            .borderRadius(Dimensions.borderRadius)
            .margin({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

            // ---- About ----
            Text('关于')
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .padding({ left: Dimensions.horizontalPadding, top: 20, bottom: 8 })
              .alignSelf(ItemAlign.Start)

            Column() {
              this.SettingRow('版本信息', `v${this.appVersion}`, () => {})
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('用户协议', '›', () => {})
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('隐私政策', '›', () => {})
              Divider().strokeWidth(0.5).color(Colors.divider).margin({ left: 16, right: 16 })
              this.SettingRow('开源许可', '›', () => {})
            }
            .backgroundColor(Colors.cardBackground)
            .borderRadius(Dimensions.borderRadius)
            .margin({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

            Button('退出登录')
              .fontSize(Dimensions.fontSizeLG)
              .fontColor(Colors.primary)
              .backgroundColor(Colors.cardBackground)
              .borderRadius(Dimensions.borderRadius)
              .width('90%')
              .height(48)
              .margin({ top: 30, bottom: 40 })
              .onClick(() => { this.showLogoutDialog = true })
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Logout dialog
      if (this.showLogoutDialog) {
        Column() {
          Column() {
            Text('退出登录')
              .fontSize(Dimensions.fontSizeXL)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.textPrimary)
              .margin({ bottom: 12 })

            Text('确定要退出当前账号吗？')
              .fontSize(Dimensions.fontSizeMD)
              .fontColor(Colors.textSecondary)
              .margin({ bottom: 20 })

            Row() {
              Button('取消')
                .fontSize(Dimensions.fontSizeMD)
                .fontColor(Colors.textPrimary)
                .backgroundColor('#F5F5F7')
                .borderRadius(Dimensions.borderRadius)
                .layoutWeight(1)
                .height(44)
                .margin({ right: 12 })
                .onClick(() => { this.showLogoutDialog = false })

              Button('确定')
                .fontSize(Dimensions.fontSizeMD)
                .fontColor('#FFFFFF')
                .backgroundColor(Colors.primary)
                .borderRadius(Dimensions.borderRadius)
                .layoutWeight(1)
                .height(44)
                .onClick(() => { this.showLogoutDialog = false })
            }
            .width('100%')
            .margin({ top: 8 })
          }
          .backgroundColor(Colors.cardBackground)
          .borderRadius(14)
          .padding(24)
          .width('80%')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SettingRow(label: string, value: string, onClick: () => void) {
    Row() {
      Text(label)
        .fontSize(Dimensions.fontSizeMD)
        .fontColor(Colors.textPrimary)
        .layoutWeight(1)
      Text(value)
        .fontSize(Dimensions.fontSizeSM)
        .fontColor(Colors.textHint)
        .margin({ right: 4 })
    }
    .width('100%')
    .padding(16)
    .onClick(onClick)
  }

  private cycleTheme(): void {
    const modes = ['跟随系统', '浅色模式', '深色模式']
    const idx = modes.indexOf(this.themeMode)
    this.themeMode = modes[(idx + 1) % modes.length]
  }
}
