import { Colors, Dimensions } from '../common/Constants'

@Component
export struct PlayControlBar {
  @Prop isPlaying: boolean = false
  onTogglePlay?: () => void = undefined
  onPrev?: () => void = undefined
  onNext?: () => void = undefined

  build() {
    Row() {
      // Previous
      Image($r('app.media.ic_prev'))
        .width(Dimensions.iconLarge)
        .height(Dimensions.iconLarge)
        .onClick(() => {
          if (this.onPrev) this.onPrev()
        })

      Blank()

      // Play/Pause
      Image(this.isPlaying ?
        $r('app.media.ic_pause') : $r('app.media.ic_play_filled'))
        .width(56)
        .height(56)
        .onClick(() => {
          if (this.onTogglePlay) this.onTogglePlay()
        })

      Blank()

      // Next
      Image($r('app.media.ic_next'))
        .width(Dimensions.iconLarge)
        .height(Dimensions.iconLarge)
        .onClick(() => {
          if (this.onNext) this.onNext()
        })
    }
    .width('100%')
    .padding({ left: 40, right: 40 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}
