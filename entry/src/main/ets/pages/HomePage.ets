import { Colors, Dimensions } from '../common/Constants'
import { Banner, Playlist } from '../model/PlaylistModel'
import { Song, Chart } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { BannerCarousel } from '../components/BannerCarousel'
import { SectionHeader } from '../components/SectionHeader'
import { PlaylistCard } from '../components/PlaylistCard'
import { SongListItem } from '../components/SongListItem'
import {
  MOCK_BANNERS, getRecommendedPlaylists, getPopularPlaylists,
  getNewSongs, MOCK_CHARTS, getRecentSongs, getPlaylistById, getChartById
} from '../data/MockData'
import router from '@ohos.router'

@Entry
@Component
export struct HomePage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State banners: Banner[] = MOCK_BANNERS
  @State recommendedPlaylists: Playlist[] = getRecommendedPlaylists()
  @State popularPlaylists: Playlist[] = getPopularPlaylists()
  @State newSongs: Song[] = getNewSongs()
  @State charts: Chart[] = MOCK_CHARTS
  @State recentSongs: Song[] = getRecentSongs()

  build() {
    Scroll() {
      Column() {
        // ---- Banner Carousel ----
        BannerCarousel({
          banners: this.banners,
          onBannerClick: (banner: Banner) => { this.handleBannerClick(banner) }
        })
        .margin({ top: Dimensions.statusBarHeight + 10 })

        // ---- Recommended Playlists ----
        SectionHeader({ title: '为你推荐', showMore: true })

        Scroll() {
          Row() {
            ForEach(this.recommendedPlaylists.slice(0, 6), (playlist: Playlist) => {
              Column() {
                Stack() {
                  Image(this.getRecommendCoverResource(playlist.id))
                    .width(180)
                    .aspectRatio(1)
                    .borderRadius(Dimensions.borderRadius)
                    .objectFit(ImageFit.Cover)

                  // Tag label
                  if (playlist.tags) {
                    Text(playlist.tags?.join(' · ') || '')
                      .fontSize(10)
                      .fontColor(Color.White)
                      .backgroundColor('rgba(0,0,0,0.5)')
                      .borderRadius(4)
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .position({ x: 8, y: 8 })
                  }

                  // Play button
                  Image($r('app.media.ic_play_filled'))
                    .width(40)
                    .height(40)
                    .fillColor(Color.White)
                    .position({ x: '50%', y: '50%' })
                    .translate({ x: '-50%', y: '-50%' })
                    .opacity(0.8)
                }

                // Title
                Text(`"${playlist.name || '未知歌单'}"`)
                  .fontSize(Dimensions.fontSizeSM)
                  .fontColor(Colors.textPrimary)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width(180)
                  .margin({ top: 8 })
                  .lineHeight(18)
              }
              .margin({ right: 16 })
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/PlaylistDetailPage',
                  params: { playlistId: playlist.id }
                })
              })
            })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

        // ---- Popular Playlists ----
        SectionHeader({ title: '热门歌单', showMore: true })

        Grid() {
          ForEach(this.popularPlaylists.slice(0, 6), (playlist: Playlist) => {
            GridItem() {
              PlaylistCard({ playlist: playlist, cardSize:'large' })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/PlaylistDetailPage',
                    params: { playlistId: playlist.id }
                  })
                })
            }
            .height('auto')
          })
        }
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(12)
        .rowsGap(16)
        .width('100%')
        .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding })

        // ---- New Songs Express ----
        SectionHeader({ title: '新歌速递', showMore: true })

        Column() {
          ForEach(this.newSongs.slice(0, 6), (song: Song, index: number) => {
            SongListItem({
              song: song, showIndex: true, index: index, showCover: true,
              onPlayClick: (s: Song) => { this.playerVM.playSong(s, this.newSongs, index) }
            })
          })
        }

        // ---- Charts ----
        SectionHeader({ title: '排行榜', showMore: true })

        Row() {
          ForEach(this.charts.slice(0, 3), (chart: Chart) => {
            Column() {
              Stack() {
                Image(this.getChartCoverResource(chart.id))
                  .width('100%')
                  .height(110)
                  .borderRadius(Dimensions.borderRadius)
                  .objectFit(ImageFit.Cover)
                Text(chart.name)
                  .fontSize(Dimensions.fontSizeMD)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .position({ x: 10, y: 12 })
              }
              .width('100%')
              .height(110)

              ForEach(chart.songs.slice(0, 3), (song: Song, idx: number) => {
                Text(`${idx + 1}. ${song.name} - ${song.artist}`)
                  .fontSize(Dimensions.fontSizeXS)
                  .fontColor(Colors.textSecondary)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .width('100%')
                  .padding({ top: 3, bottom: 2 })
              })
            }
            .layoutWeight(1)
            .padding({ left: 4, right: 4 })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/SongListPage',
                params: { chartId: chart.id, title: chart.name, songs: chart.songs }
              })
            })
          })
        }
        .width('100%')
        .padding({ left: Dimensions.horizontalPadding - 4, right: Dimensions.horizontalPadding - 4 })

        // ---- Recently Played ----
        SectionHeader({ title: '最近播放', showMore: true })

        Column() {
          ForEach(this.recentSongs.slice(0, 10), (song: Song, index: number) => {
            SongListItem({
              song: song, showIndex: true, index: index, showCover: true,
              onPlayClick: (s: Song) => { this.playerVM.playSong(s, this.recentSongs, index) }
            })
          })
        }

        Row().height(80)
      }
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  private getChartCoverResource(chartId: string): Resource {
    const resources: Record<string, Resource> = {
      'ch1': $r('app.media.cover_chart_01'),
      'ch2': $r('app.media.cover_chart_02'),
      'ch3': $r('app.media.cover_chart_03'),
      'ch4': $r('app.media.cover_chart_04'),
    }
    return resources[chartId] || $r('app.media.cover_chart_01')
  }

  private getRecommendCoverResource(playlistId: string): Resource {
    const index = parseInt(playlistId.replace(/[^0-9]/g, '')) || 1
    const resources: Resource[] = [
      $r('app.media.1'), $r('app.media.2'), $r('app.media.3'), $r('app.media.4'),
      $r('app.media.5'), $r('app.media.6'), $r('app.media.7'), $r('app.media.8'),
      $r('app.media.9'), $r('app.media.10'), $r('app.media.11'), $r('app.media.12'),
    ]
    return resources[(index - 1) % resources.length]
  }

  private handleBannerClick(banner: Banner): void {
    if (banner.linkType === 'playlist') {
      const pl = getPlaylistById(banner.linkId)
      if (pl) {
        router.pushUrl({
          url: 'pages/PlaylistDetailPage',
          params: { playlistId: pl.id }
        })
      }
    } else if (banner.linkType === 'chart') {
      const chart = getChartById(banner.linkId)
      if (chart) {
        router.pushUrl({
          url: 'pages/SongListPage',
          params: { chartId: chart.id, title: chart.name, songs: chart.songs }
        })
      }
    }
  }
}
