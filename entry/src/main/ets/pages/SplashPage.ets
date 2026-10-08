import router from '@ohos.router'

@Entry
@Component
struct SplashPage {
  @State seconds: number = 4
  private intervalId: number = -1

  aboutToAppear(): void {
    this.intervalId = setInterval(() => {
      this.seconds--
      if (this.seconds <= 0) {
        this.toIndex()
      }
    }, 1000)
  }

  toIndex(): void {
    if (this.intervalId >= 0) {
      clearInterval(this.intervalId)
      this.intervalId = -1
    }
    router.pushUrl({ url: 'pages/Index' })
  }

  build() {
    Stack() {
      Image($r('app.media.48'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Fill)

      Button(`${this.seconds} 跳过`)
        .backgroundColor('rgba(0,0,0,0.5)')
        .fontColor(Color.White)
        .fontSize(14)
        .borderRadius(16)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .position({ x: '80%', y: 60 })
        .onClick(() => {
          this.toIndex()
        })

      Text('MUSIC PLAYER')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }
}
