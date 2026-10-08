import { Colors, Dimensions } from '../common/Constants'
import { User } from '../model/UserModel'
import { Playlist } from '../model/PlaylistModel'
import { MOCK_USER } from '../data/MockData'
import { PlaylistCard } from '../components/PlaylistCard'
import router from '@ohos.router'

@Entry
@Component
export struct ProfilePage {
  @State user: User = MOCK_USER
  @State activeTab: number = 0
  @State activeContentTab: number = 0
  @State weeklyReportCount: number = 3
  @State listenHours: number = 76
  @State userLevel: number = 5
  @State vipLevel: string = '贰'
  @State badgeCount: number = 2

  build() {
    Column({ space: 0 }) {
      // ========== Profile header with background ==========
      Stack() {
        // Background image
        Image($r('app.media.cover_chart_01'))
          .width('100%')
          .height(300)
          .objectFit(ImageFit.Cover)

        // Dark overlay
        Column()
          .width('100%')
          .height(300)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['rgba(0,0,0,0.4)', 0.0],
              ['rgba(0,0,0,0.0)', 1.0]
            ]
          })

        // Content overlay
        Column() {
          // ---- Top bar ----
          Row() {
            Image($r('app.media.ic_chevron_left'))
              .width(28)
              .height(28)
              .fillColor(Color.White)

            Blank()

            Row() {
              Image($r('app.media.ic_playlist_add'))
                .width(Dimensions.fontSizeLG)
                .height(Dimensions.fontSizeLG)
                .fillColor(Color.White)
                .margin({ right: 4 })
              Text('添加状态')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Color.White)
            }
          }
          .width('100%')
          .padding({ left: 12, right: Dimensions.horizontalPadding, bottom: 16 })

          // ---- Avatar + User info row (avatar left, info right) ----
          Row() {
            Image($r('app.media.img15'))
              .width(72)
              .height(72)
              .borderRadius(36)
              .objectFit(ImageFit.Cover)
              .border({ width: 3, color: Color.White })

            Column() {
              // User ID
              Text('176285422021396')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor('rgba(255,255,255,0.7)')

              // VIP badge row
              Row() {
                Row() {
                  Text('VIP')
                    .fontSize(10)
                    .fontColor('#E8C27A')
                    .fontWeight(FontWeight.Bold)
                    .backgroundColor('#1A1A1A')
                    .borderRadius(3)
                    .padding({ left: 5, right: 5, top: 2, bottom: 2 })
                  Text(`·${this.vipLevel}`)
                    .fontSize(Dimensions.fontSizeSM)
                    .fontColor(Color.White)
                    .margin({ left: 4 })
                }

                Text(`${this.badgeCount}枚徽章`)
                  .fontSize(Dimensions.fontSizeSM)
                  .fontColor('rgba(255,255,255,0.7)')
                  .margin({ left: 12 })

                Image($r('app.media.ic_chevron_right'))
                  .width(Dimensions.fontSizeSM)
                  .height(Dimensions.fontSizeSM)
                  .fillColor('rgba(255,255,255,0.5)')
              }
              .margin({ top: 6 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 14 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 20 })

          // ---- Data cards ----
          Row({ space: 12 }) {
            // 周报 card
            Column() {
              Text('周报')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Color.White)
                .opacity(0.8)
              Text(`${this.weeklyReportCount}`)
                .fontSize(Dimensions.fontSizeTitle)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ top: 4 })
            }
            .width(80)
            .height(64)
            .backgroundColor('rgba(255,255,255,0.15)')
            .borderRadius(10)
            .justifyContent(FlexAlign.Center)

            // 关注 card
            Column() {
              Text('关注')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Color.White)
                .opacity(0.8)
              Text(`${this.user.followingCount}`)
                .fontSize(Dimensions.fontSizeTitle)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .height(64)
            .backgroundColor('rgba(255,255,255,0.15)')
            .borderRadius(10)
            .justifyContent(FlexAlign.Center)

            // 粉丝 card
            Column() {
              Text('粉丝')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Color.White)
                .opacity(0.8)
              Text(`${this.user.followerCount}`)
                .fontSize(Dimensions.fontSizeTitle)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .height(64)
            .backgroundColor('rgba(255,255,255,0.15)')
            .borderRadius(10)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .margin({ bottom: 16 })

          // ---- Level + listening time ----
          Row() {
            Row() {
              Text(`Lv.${this.userLevel}`)
                .fontSize(Dimensions.fontSizeSM)
                .fontColor('rgba(255,255,255,0.8)')
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('rgba(255,255,255,0.15)')
            .borderRadius(10)
            .padding({ left: 10, right: 10, top: 4, bottom: 4 })

            Text(`${this.listenHours}小时`)
              .fontSize(Dimensions.fontSizeSM)
              .fontColor('rgba(255,255,255,0.7)')
              .margin({ left: 10 })
          }
          .width('100%')
        }
        .width('100%')
        .padding({
          left: Dimensions.horizontalPadding,
          right: Dimensions.horizontalPadding,
          top: Dimensions.statusBarHeight + 8,
          bottom: 20
        })
      }
      .width('100%')

      // ========== Quick tabs ==========
      Row() {
        ForEach(['最近', '本地', 'VIP', '会员'], (tab: string, index: number) => {
          Text(tab)
            .fontSize(Dimensions.fontSizeMD)
            .fontColor(index === this.activeTab ? Colors.textPrimary : Colors.textSecondary)
            .fontWeight(index === this.activeTab ? FontWeight.Medium : FontWeight.Normal)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .padding({ top: 10, bottom: 6 })
            .onClick(() => { this.activeTab = index })
        })
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

      if (this.activeTab === 0) {
        Divider()
          .strokeWidth(2.5)
          .width(32)
          .color(Colors.primary)
          .margin({ left: Dimensions.horizontalPadding + 8 })
      }

      Divider().strokeWidth(0.5).color(Colors.divider)

      // ========== 装扮 entry ==========
      Row() {
        Image($r('app.media.ic_playlist_add'))
          .width(Dimensions.fontSizeLG)
          .height(Dimensions.fontSizeLG)
          .fillColor(Colors.primary)
          .margin({ right: 10 })
        Text('装扮')
          .fontSize(Dimensions.fontSizeLG)
          .fontColor(Colors.textPrimary)
          .layoutWeight(1)
        Image($r('app.media.ic_chevron_right'))
          .width(Dimensions.fontSizeXL)
          .height(Dimensions.fontSizeXL)
          .fillColor(Colors.textHint)
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 14, bottom: 14 })
      .backgroundColor(Colors.cardBackground)

      Divider().strokeWidth(8).color(Colors.divider)

      // ========== Content type tabs ==========
      Row() {
        ForEach(['音乐', '播客', '笔记'], (tab: string, index: number) => {
          Text(tab)
            .fontSize(Dimensions.fontSizeLG)
            .fontWeight(index === this.activeContentTab ? FontWeight.Bold : FontWeight.Normal)
            .fontColor(index === this.activeContentTab ? Colors.textPrimary : Colors.textSecondary)
            .padding({ top: 12, bottom: 6 })
            .margin({ right: 24 })
            .onClick(() => { this.activeContentTab = index })
        })
      }
      .width('100%')
      .padding({ left: Dimensions.horizontalPadding })

      Divider().strokeWidth(0.5).color(Colors.divider)

      // ========== Scrollable content ==========
      Scroll() {
        Column({ space: 0 }) {
          // ---- 近期 section ----
          Row() {
            Text('近期')
              .fontSize(Dimensions.fontSizeXL)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.textPrimary)

            Blank()

            Text(`创建 ${this.user.createdPlaylists.length}`)
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textSecondary)
              .margin({ right: 4 })

            Image($r('app.media.ic_chevron_right'))
              .width(Dimensions.fontSizeSM)
              .height(Dimensions.fontSizeSM)
              .fillColor(Colors.textHint)
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 16, bottom: 12 })

          // Playlist cards (full-width horizontal style)
          ForEach(this.user.createdPlaylists, (playlist: Playlist) => {
            Row() {
              // Cover image
              Image($r('app.media.1'))
                .width(56)
                .height(56)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)

              Column() {
                Row() {
                  Text('♪')
                    .fontSize(Dimensions.fontSizeSM)
                    .fontColor(Colors.primary)
                    .margin({ right: 4 })
                  Text(playlist.name || '未知歌单')
                    .fontSize(Dimensions.fontSizeMD)
                    .fontColor(Colors.textPrimary)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }

                Row() {
                  Text(`${playlist.songCount || 0}首`)
                    .fontSize(Dimensions.fontSizeXS)
                    .fontColor(Colors.textSecondary)
                    .margin({ top: 4 })
                  if (playlist.playCount) {
                    Text(` · ${playlist.playCount}次播放`)
                      .fontSize(Dimensions.fontSizeXS)
                      .fontColor(Colors.textHint)
                      .margin({ top: 4 })
                  }
                }
                .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 12 })

              Image($r('app.media.ic_chevron_right'))
                .width(Dimensions.fontSizeLG)
                .height(Dimensions.fontSizeLG)
                .fillColor(Colors.textHint)
            }
            .width('100%')
            .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 12, bottom: 12 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/PlaylistDetailPage',
                params: { playlistId: playlist.id }
              })
            })

            Divider().strokeWidth(0.5).color(Colors.divider)
              .margin({ left: Dimensions.horizontalPadding + 68 })
          })

          // ---- 听歌排行 entry ----
          Row() {
            Text('听歌排行')
              .fontSize(Dimensions.fontSizeMD)
              .fontColor(Colors.textPrimary)
              .layoutWeight(1)

            Text('不置顶')
              .fontSize(Dimensions.fontSizeSM)
              .fontColor(Colors.textHint)
              .margin({ right: 4 })

            Image($r('app.media.ic_chevron_right'))
              .width(Dimensions.fontSizeSM)
              .height(Dimensions.fontSizeSM)
              .fillColor(Colors.textHint)
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 16, bottom: 16 })

          Divider().strokeWidth(8).color(Colors.divider)

          // ---- Content feed section ----
          Row() {
            Image($r('app.media.2'))
              .width(40)
              .height(40)
              .borderRadius(20)
              .objectFit(ImageFit.Cover)
              .margin({ right: 10 })

            Column() {
              Text('Me-Jamvana/ZEKEN')
                .fontSize(Dimensions.fontSizeSM)
                .fontColor(Colors.textPrimary)
                .fontWeight(FontWeight.Medium)
              Text('推荐 · 漫游 · 笔记 · 我的')
                .fontSize(Dimensions.fontSizeXS)
                .fontColor(Colors.textSecondary)
                .margin({ top: 2 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Image($r('app.media.ic_more'))
              .width(Dimensions.fontSizeLG)
              .height(Dimensions.fontSizeLG)
              .fillColor(Colors.textHint)
          }
          .width('100%')
          .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 14, bottom: 14 })

          Divider().strokeWidth(0.5).color(Colors.divider)

          // Bottom spacer for tab bar
          Row().height(80)
        }
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }
}
