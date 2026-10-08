import { Dimensions } from '../common/Constants'
import { Song } from '../model/SongModel'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'

interface UserPost {
  id: number
  userName: string
  avatar: string
  content: string
  songName: string
  singerName: string
  songCover: string
  commentCount: number
  likeCount: number
  isLiked: boolean
}

@Entry
@Component
export struct LibraryPage {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  
  @State posts: UserPost[] = [
    {
      id: 1,
      userName: '不想想名字',
      avatar: 'img2',
      content: '在这首温柔的旋律中，仿佛乘坐一叶扁舟，缓缓漂流在名为回忆的时光之河上。',
      songName: '晨光破晓',
      singerName: '歌手A',
      songCover: '3',
      commentCount: 604,
      likeCount: 23382,
      isLiked: false
    },
    {
      id: 2,
      userName: '豆包的包',
      avatar: 'img3',
      content: '无论梦想多么遥远，只要心中有火，眼里有光，就没有到达不了的远方。',
      songName: '梦想翱翔',
      singerName: '歌手B',
      songCover: '7',
      commentCount: 1237,
      likeCount: 5482,
      isLiked: false
    },
    {
      id: 3,
      userName: '快乐星球居民',
      avatar: 'img4',
      content: '轻柔的吉他弹奏，搭配歌手如泉水般清澈的嗓音，营造出一种难以言喻的宁静与安详。',
      songName: '心海扬帆',
      singerName: '歌手C',
      songCover: '10',
      commentCount: 8425,
      likeCount: 4234,
      isLiked: false
    },
    {
      id: 4,
      userName: '遗忘',
      avatar: 'img5',
      content: '每当听到这首歌，就仿佛回到了那个充满青春气息的夏天，阳光、沙滩、海浪，还有那些美好的回忆。',
      songName: '夏日回忆',
      singerName: '歌手D',
      songCover: '13',
      commentCount: 3256,
      likeCount: 18934,
      isLiked: false
    },
    {
      id: 5,
      userName: '广式青年的青春',
      avatar: 'img6',
      content: '这首歌曲的编曲非常用心，每一个音符都恰到好处，让人沉浸其中无法自拔。',
      songName: '星空漫步',
      singerName: '歌手E',
      songCover: '16',
      commentCount: 7821,
      likeCount: 28931,
      isLiked: false
    },
    {
      id: 6,
      userName: '沈星回的宝剑',
      avatar: 'img7',
      content: '这首歌的歌词写得太动人了，每一句都直击人心，让人忍不住单曲循环。',
      songName: '时光倒流',
      singerName: '歌手F',
      songCover: '19',
      commentCount: 4521,
      likeCount: 15632,
      isLiked: false
    },
    {
      id: 7,
      userName: '秦彻的109',
      avatar: 'img8',
      content: '深夜里听这首歌，总能让人静下心来，忘却一天的疲惫和烦恼。',
      songName: '静夜思',
      singerName: '歌手G',
      songCover: '22',
      commentCount: 2876,
      likeCount: 9876,
      isLiked: false
    },
    {
      id: 8,
      userName: '风的记忆',
      avatar: 'img9',
      content: '这是我最喜欢的一首励志歌曲，每次听到都能给我满满的正能量。',
      songName: '逆风飞翔',
      singerName: '歌手H',
      songCover: '24',
      commentCount: 6789,
      likeCount: 32567,
      isLiked: false
    },
    {
      id: 9,
      userName: '星河漫步',
      avatar: 'img10',
      content: '古典与现代的完美结合，这首歌曲的编曲真的太惊艳了！',
      songName: '古韵新声',
      singerName: '歌手I',
      songCover: '26',
      commentCount: 8934,
      likeCount: 45234,
      isLiked: false
    },
    {
      id: 10,
      userName: '时光旅人',
      avatar: 'img11',
      content: '第一次听到这首歌就被深深吸引，旋律优美，歌词感人。',
      songName: '遇见',
      singerName: '歌手J',
      songCover: '28',
      commentCount: 5621,
      likeCount: 28765,
      isLiked: false
    },
    {
      id: 11,
      userName: '星辰大海',
      avatar: 'img12',
      content: '这首歌陪伴我度过了很多艰难的时光，是我心中永远的经典。',
      songName: '永不放弃',
      singerName: '歌手K',
      songCover: '30',
      commentCount: 7834,
      likeCount: 38921,
      isLiked: false
    },
    {
      id: 12,
      userName: '清风明月',
      avatar: 'img13',
      content: '轻快的节奏，欢快的旋律，听了心情都会变好！',
      songName: '快乐出发',
      singerName: '歌手L',
      songCover: '32',
      commentCount: 3421,
      likeCount: 18934,
      isLiked: false
    }
  ]

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('动态')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .padding({ top: Dimensions.statusBarHeight + 16, left: Dimensions.horizontalPadding, bottom: 16 })
      .backgroundColor('#FFFFFF')

      List({ space: 0 }) {
        ForEach(this.posts, (post: UserPost) => {
          ListItem() {
            Column({ space: 0 }) {
              Row({ space: 12 }) {
                Image($r(`app.media.${post.avatar}`))
                  .width(48)
                  .height(48)
                  .borderRadius(24)
                  .objectFit(ImageFit.Cover)
                Column({ space: 4 }) {
                  Text(post.userName)
                    .fontSize(Dimensions.fontSizeMD)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black)
                  Text(post.content)
                    .fontSize(Dimensions.fontSizeSM)
                    .fontColor(Color.Grey)
                    .maxLines(3)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 16 })

              Row({ space: 12 }) {
                Image($r(`app.media.${post.songCover}`))
                  .width(64)
                  .height(64)
                  .borderRadius(8)
                  .objectFit(ImageFit.Cover)
                Column({ space: 4 }) {
                  Text(post.songName)
                    .fontSize(Dimensions.fontSizeSM)
                    .fontColor(Color.Black)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                  Text(post.singerName)
                    .fontSize(Dimensions.fontSizeXS)
                    .fontColor(Color.Grey)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                Image($r('app.media.4'))
                  .width(32)
                  .height(32)
                  .fillColor('#1a1a1a')
                  .onClick(() => {
                    const songData: Song = {
                      id: post.id.toString(),
                      name: post.songName,
                      artist: post.singerName,
                      artistId: '',
                      album: '',
                      albumId: '',
                      duration: 240,
                      coverUrl: post.songCover,
                      sourceUrl: '',
                      isLiked: false,
                      isDownloaded: false
                    }
                    this.playerVM.playSong(songData, [songData], 0)
                  })
              }
              .width('100%')
              .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 12 })
              .backgroundColor('#F5F5F5')

              Row({ space: 0 }) {
                Row({ space: 4 }) {
                  Image($r('app.media.ic_share'))
                    .width(20)
                    .height(20)
                    .fillColor(Color.Grey)
                  Text('分享')
                    .fontSize(Dimensions.fontSizeXS)
                    .fontColor(Color.Grey)
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.End)

                Row({ space: 4 }) {
                  Image($r('app.media.ic_comment'))
                    .width(20)
                    .height(20)
                    .fillColor(Color.Grey)
                  Text(post.commentCount.toString())
                    .fontSize(Dimensions.fontSizeXS)
                    .fontColor(Color.Grey)
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)

                Row({ space: 4 }) {
                  Image(post.isLiked ? $r('app.media.ic_like_filled') : $r('app.media.ic_like'))
                    .width(20)
                    .height(20)
                    .fillColor(post.isLiked ? '#FF3B30' : Color.Grey)
                  Text(post.likeCount.toString())
                    .fontSize(Dimensions.fontSizeXS)
                    .fontColor(post.isLiked ? '#FF3B30' : Color.Grey)
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Start)
                .onClick(() => {
                  post.isLiked = !post.isLiked
                  post.likeCount += post.isLiked ? 1 : -1
                })
              }
              .width('100%')
              .padding({ left: Dimensions.horizontalPadding, right: Dimensions.horizontalPadding, top: 12, bottom: 16 })
              .backgroundColor('#F5F5F5')

              Divider().strokeWidth(0.5).color('rgba(0,0,0,0.05)')
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
          }
          .height('auto')
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .layoutWeight(1)

      Row().height(60)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
