import { Colors, Dimensions } from '../common/Constants'
import { Banner } from '../model/PlaylistModel'

@Component
export struct BannerCarousel {
  @Prop banners: Banner[] = []
  onBannerClick?: (banner: Banner) => void = undefined

  private swiperController: SwiperController = new SwiperController()
  @State currentIndex: number = 0

  build() {
    Stack() {
      Swiper(this.swiperController) {
        ForEach(this.banners, (banner: Banner, index: number) => {
          Stack() {
            Image(this.getBannerResource(index))
              .width('100%')
              .height('100%')
              .borderRadius(Dimensions.borderRadiusLarge)
              .objectFit(ImageFit.Cover)

            Column() {
              Text(banner.title)
                .fontSize(Dimensions.fontSizeXL)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: 20 })
            .position({ x: 0, y: '100%' })
            .translate({ x: 0, y: -44 })

            Row()
              .width('100%')
              .height('100%')
              .borderRadius(Dimensions.borderRadiusLarge)
              .backgroundColor('#00000020')
          }
          .width('100%')
          .height(Dimensions.bannerHeight)
          .borderRadius(Dimensions.borderRadiusLarge)
          .onClick(() => {
            if (this.onBannerClick) {
              this.onBannerClick(banner)
            }
          })
        })
      }
      .autoPlay(true)
      .interval(4000)
      .indicator(false)
      .loop(true)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height(Dimensions.bannerHeight)

      // Custom indicator overlay
      Row() {
        ForEach(this.banners, (_: Banner, idx: number) => {
          Circle()
            .width(idx === this.currentIndex ? 8 : 6)
            .height(idx === this.currentIndex ? 8 : 6)
            .fill(idx === this.currentIndex ? Color.White : '#80FFFFFF')
            .margin({ left: 3, right: 3 })
        })
      }
      .position({ x: '50%', y: Dimensions.bannerHeight - 18 })
      .translate({ x: '-50%', y: 0 })
    }
    .width('100%')
    .height(Dimensions.bannerHeight)
    .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })
  }

  private getBannerResource(index: number): Resource {
    const bannerResources: Resource[] = [
      $r('app.media.40'),
      $r('app.media.41'),
      $r('app.media.42'),
      $r('app.media.43'),
      $r('app.media.44'),
      $r('app.media.45'),
    ]
    return bannerResources[index % bannerResources.length]
  }
}
