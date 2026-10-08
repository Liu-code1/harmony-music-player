import { Song, LyricLine, Chart } from '../model/SongModel'
import { Playlist, Banner } from '../model/PlaylistModel'
import { HotSearch } from '../model/SearchModel'
import { User } from '../model/UserModel'

export const MOCK_SONGS: Song[] = [
  {
    id: 's1', name: '晴天', artist: '周杰伦', artistId: 'a1', album: '叶惠美', albumId: 'al1',
    duration: 269000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', isLiked: true, isDownloaded: true
  },
  {
    id: 's2', name: '七里香', artist: '周杰伦', artistId: 'a1', album: '七里香', albumId: 'al2',
    duration: 300000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's3', name: '夜曲', artist: '周杰伦', artistId: 'a1', album: '十一月的肖邦', albumId: 'al3',
    duration: 240000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's4', name: '稻香', artist: '周杰伦', artistId: 'a1', album: '魔杰座', albumId: 'al4',
    duration: 222000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3', isLiked: false, isDownloaded: true
  },
  {
    id: 's5', name: '告白气球', artist: '周杰伦', artistId: 'a1', album: '周杰伦的床边故事', albumId: 'al5',
    duration: 205000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's6', name: '起风了', artist: '买辣椒也用券', artistId: 'a2', album: '起风了', albumId: 'al6',
    duration: 267000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's7', name: '光年之外', artist: '邓紫棋', artistId: 'a3', album: '光年之外', albumId: 'al7',
    duration: 245000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3', isLiked: true, isDownloaded: true
  },
  {
    id: 's8', name: '平凡之路', artist: '朴树', artistId: 'a4', album: '平凡之路', albumId: 'al8',
    duration: 310000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's9', name: '年少有为', artist: '李荣浩', artistId: 'a5', album: '耳朵', albumId: 'al9',
    duration: 248000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's10', name: '好久不见', artist: '陈奕迅', artistId: 'a6', album: '认了吧', albumId: 'al10',
    duration: 263000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's11', name: '演员', artist: '薛之谦', artistId: 'a7', album: '绅士', albumId: 'al11',
    duration: 258000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's12', name: '消愁', artist: '毛不易', artistId: 'a8', album: '明日之子', albumId: 'al12',
    duration: 280000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3', isLiked: true, isDownloaded: true
  },
  {
    id: 's13', name: '体面', artist: '于文文', artistId: 'a9', album: '体面', albumId: 'al13',
    duration: 252000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's14', name: '勇气', artist: '梁静茹', artistId: 'a10', album: '勇气', albumId: 'al14',
    duration: 233000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's15', name: '蓝莲花', artist: '许巍', artistId: 'a11', album: '时光·漫步', albumId: 'al15',
    duration: 290000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's16', name: '遇见', artist: '孙燕姿', artistId: 'a12', album: 'The Moment', albumId: 'al16',
    duration: 215000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3', isLiked: false, isDownloaded: true
  },
  {
    id: 's17', name: '成都', artist: '赵雷', artistId: 'a13', album: '无法长大', albumId: 'al17',
    duration: 308000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's18', name: '后来', artist: '刘若英', artistId: 'a14', album: '我等你', albumId: 'al18',
    duration: 275000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3', isLiked: false, isDownloaded: false
  },
  {
    id: 's19', name: '那些年', artist: '胡夏', artistId: 'a15', album: '那些年，我们一起追的女孩', albumId: 'al19',
    duration: 254000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3', isLiked: true, isDownloaded: false
  },
  {
    id: 's20', name: '小幸运', artist: '田馥甄', artistId: 'a16', album: '小幸运', albumId: 'al20',
    duration: 268000, coverUrl: '', sourceUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3', isLiked: false, isDownloaded: true
  },
]

export const MOCK_LYRICS: Record<string, LyricLine[]> = {
  's1': [
    { time: 0, text: '晴天 - 周杰伦' },
    { time: 3000, text: '故事的小黄花' },
    { time: 8000, text: '从出生那年就飘着' },
    { time: 14000, text: '童年的荡秋千' },
    { time: 19000, text: '随记忆一直晃到现在' },
    { time: 25000, text: 'Re So So Si Do Si La' },
    { time: 31000, text: 'So La Si Si Si Si La Si La So' },
    { time: 37000, text: '吹着前奏 望着天空' },
    { time: 43000, text: '我想起花瓣试着掉落' },
    { time: 50000, text: '为你翘课的那一天' },
    { time: 55000, text: '花落的那一天' },
    { time: 60000, text: '教室的那一间' },
    { time: 65000, text: '我怎么看不见' },
    { time: 71000, text: '消失的下雨天' },
    { time: 77000, text: '我好想再淋一遍' },
    { time: 83000, text: '没想到失去的勇气我还留着' },
    { time: 92000, text: '好想再问一遍' },
    { time: 98000, text: '你会等待还是离开' },
    { time: 107000, text: '刮风这天 我试过握着你手' },
    { time: 115000, text: '但偏偏 雨渐渐' },
    { time: 120000, text: '大到我看你不见' },
    { time: 128000, text: '还要多久 我才能在你身边' },
    { time: 137000, text: '等到放晴的那天' },
    { time: 142000, text: '也许我会比较好一点' },
  ],
  's2': [
    { time: 0, text: '七里香 - 周杰伦' },
    { time: 5000, text: '窗外的麻雀 在电线杆上多嘴' },
    { time: 12000, text: '你说这一句 很有夏天的感觉' },
    { time: 19000, text: '手中的铅笔 在纸上来来回回' },
    { time: 26000, text: '我用几行字形容你是我的谁' },
    { time: 34000, text: '秋刀鱼的滋味 猫跟你都想了解' },
    { time: 42000, text: '初恋的香味就这样被我们寻回' },
    { time: 50000, text: '那温暖的阳光 像刚摘的鲜艳草莓' },
    { time: 58000, text: '你说你舍不得吃掉这一种感觉' },
    { time: 66000, text: '雨下整夜 我的爱溢出就像雨水' },
    { time: 75000, text: '院子落叶 跟我的思念厚厚一叠' },
    { time: 84000, text: '几句是非 也无法将我的热情冷却' },
    { time: 93000, text: '你出现在我诗的每一页' },
  ],
  's7': [
    { time: 0, text: '光年之外 - 邓紫棋' },
    { time: 5000, text: '感受停在我发端的指尖' },
    { time: 12000, text: '如何瞬间 冻结时间' },
    { time: 19000, text: '记住望着我坚定的双眼' },
    { time: 26000, text: '也许已经 没有明天' },
    { time: 33000, text: '面对浩瀚的星海' },
    { time: 39000, text: '我们微小得像尘埃' },
    { time: 44000, text: '漂浮在 一片无奈' },
    { time: 52000, text: '缘分让我们相遇乱世以外' },
    { time: 59000, text: '命运却要我们危难中相爱' },
    { time: 67000, text: '也许未来遥远在光年之外' },
    { time: 74000, text: '我愿守候未知里为你等待' },
  ],
}

export const MOCK_CHARTS: Chart[] = [
  {
    id: 'ch1', name: '飙升榜', coverUrl: '', description: '实时上升最快的歌曲',
    songs: [MOCK_SONGS[2], MOCK_SONGS[0], MOCK_SONGS[6], MOCK_SONGS[11], MOCK_SONGS[16],
            MOCK_SONGS[3], MOCK_SONGS[9], MOCK_SONGS[14], MOCK_SONGS[8], MOCK_SONGS[18]]
  },
  {
    id: 'ch2', name: '热歌榜', coverUrl: '', description: '当前最热歌曲TOP100',
    songs: [MOCK_SONGS[0], MOCK_SONGS[1], MOCK_SONGS[4], MOCK_SONGS[6], MOCK_SONGS[9],
            MOCK_SONGS[15], MOCK_SONGS[5], MOCK_SONGS[11], MOCK_SONGS[7], MOCK_SONGS[13]]
  },
  {
    id: 'ch3', name: '新歌榜', coverUrl: '', description: '最新发行的热门歌曲',
    songs: [MOCK_SONGS[5], MOCK_SONGS[11], MOCK_SONGS[8], MOCK_SONGS[18], MOCK_SONGS[2],
            MOCK_SONGS[13], MOCK_SONGS[16], MOCK_SONGS[3], MOCK_SONGS[12], MOCK_SONGS[19]]
  },
  {
    id: 'ch4', name: '原创榜', coverUrl: '', description: '原创音乐人作品排行',
    songs: [MOCK_SONGS[7], MOCK_SONGS[14], MOCK_SONGS[16], MOCK_SONGS[6], MOCK_SONGS[10],
            MOCK_SONGS[17], MOCK_SONGS[8], MOCK_SONGS[11], MOCK_SONGS[2], MOCK_SONGS[0]]
  },
]

export const MOCK_PLAYLISTS: Playlist[] = [
  {
    id: 'pl1', name: '华语经典 | 8090青春回忆录', coverUrl: '',
    description: '那些年陪伴我们成长的华语金曲', songCount: 88, playCount: 5230000,
    creator: '音乐小助手', songs: MOCK_SONGS.slice(0, 10), tags: ['经典', '怀旧'],
    isCreatedByUser: false, isCollected: true
  },
  {
    id: 'pl2', name: '深度睡眠 | 助眠轻音乐', coverUrl: '',
    description: '精选舒缓音乐，伴你安然入眠', songCount: 45, playCount: 1820000,
    creator: '放松音乐', songs: MOCK_SONGS.slice(10, 15), tags: ['助眠', '轻音乐'],
    isCreatedByUser: false, isCollected: false
  },
  {
    id: 'pl3', name: '高效工作 | 专注力BGM', coverUrl: '',
    description: '提升工作效率的背景音乐精选', songCount: 52, playCount: 980000,
    creator: '工作助手', songs: MOCK_SONGS.slice(5, 15), tags: ['工作', '专注'],
    isCreatedByUser: false, isCollected: true
  },
  {
    id: 'pl4', name: '摇滚经典 | 永不褪色的激情', coverUrl: '',
    description: '殿堂级摇滚乐队经典作品合集', songCount: 66, playCount: 2100000,
    creator: '摇滚电台', songs: MOCK_SONGS.slice(0, 8), tags: ['摇滚', '经典'],
    isCreatedByUser: false, isCollected: false
  },
  {
    id: 'pl5', name: '甜蜜情歌 | 告白专用曲', coverUrl: '',
    description: '最甜蜜的情歌精选，送给最爱的TA', songCount: 55, playCount: 3650000,
    creator: '情歌电台', songs: MOCK_SONGS.slice(3, 13), tags: ['情歌', '甜蜜'],
    isCreatedByUser: false, isCollected: true
  },
  {
    id: 'pl6', name: '民谣在路上', coverUrl: '',
    description: '一把吉他，一个故事', songCount: 70, playCount: 1560000,
    creator: '民谣小馆', songs: [MOCK_SONGS[14], MOCK_SONGS[16], MOCK_SONGS[7], MOCK_SONGS[11]],
    tags: ['民谣', '吉他'],
    isCreatedByUser: false, isCollected: false
  },
  {
    id: 'pl7', name: '健身动力 | 燃脂跑步歌单', coverUrl: '',
    description: '高能节拍，助你突破极限', songCount: 40, playCount: 890000,
    creator: '运动音乐', songs: MOCK_SONGS.slice(6, 14), tags: ['运动', '燃脂'],
    isCreatedByUser: false, isCollected: false
  },
  {
    id: 'pl8', name: '咖啡时光 | 午后爵士', coverUrl: '',
    description: '慵懒午后，一杯咖啡一首爵士', songCount: 38, playCount: 720000,
    creator: '爵士电台', songs: MOCK_SONGS.slice(0, 6), tags: ['爵士', '咖啡'],
    isCreatedByUser: false, isCollected: false
  },
  {
    id: 'upl1', name: '我的最爱', coverUrl: '',
    description: '反复循环的宝藏歌曲', songCount: 25, playCount: 320,
    creator: '我', songs: [MOCK_SONGS[0], MOCK_SONGS[6], MOCK_SONGS[10], MOCK_SONGS[16], MOCK_SONGS[18]],
    tags: ['收藏'],
    isCreatedByUser: true, isCollected: false
  },
  {
    id: 'upl2', name: '睡前故事', coverUrl: '',
    description: '安静的晚安曲', songCount: 12, playCount: 150,
    creator: '我', songs: [MOCK_SONGS[1], MOCK_SONGS[7], MOCK_SONGS[14]],
    tags: ['安静'],
    isCreatedByUser: true, isCollected: false
  },
]

export const MOCK_BANNERS: Banner[] = [
  { id: 'b1', imageUrl: '', title: '周杰伦经典回顾', linkType: 'playlist', linkId: 'pl1' },
  { id: 'b2', imageUrl: '', title: '新歌首发：最新专辑上线', linkType: 'playlist', linkId: 'pl2' },
  { id: 'b3', imageUrl: '', title: '热歌榜TOP100', linkType: 'chart', linkId: 'ch2' },
  { id: 'b4', imageUrl: '', title: '助眠轻音乐精选', linkType: 'playlist', linkId: 'pl2' },
  { id: 'b5', imageUrl: '', title: '夏季音乐节来袭', linkType: 'playlist', linkId: 'pl4' },
  { id: 'b6', imageUrl: '', title: '520情歌特辑', linkType: 'playlist', linkId: 'pl5' },
]

export const MOCK_HOT_SEARCHES: HotSearch[] = [
  { id: 'h1', keyword: '周杰伦', searchCount: 8920000, tag: '爆' },
  { id: 'h2', keyword: '晴天', searchCount: 5670000, tag: '热' },
  { id: 'h3', keyword: '邓紫棋', searchCount: 4320000, tag: '热' },
  { id: 'h4', keyword: '华语经典', searchCount: 3210000, tag: '热' },
  { id: 'h5', keyword: '民谣吉他', searchCount: 2890000, tag: '热' },
  { id: 'h6', keyword: '睡前音乐', searchCount: 2450000, tag: '新' },
  { id: 'h7', keyword: '摇滚合集', searchCount: 1980000, tag: '' },
  { id: 'h8', keyword: '抖音热歌', searchCount: 1560000, tag: '新' },
  { id: 'h9', keyword: '翻唱经典', searchCount: 1230000, tag: '' },
  { id: 'h10', keyword: '治愈系', searchCount: 980000, tag: '新' },
]

export const MOCK_USER: User = {
  id: 'u1',
  nickname: '音乐爱好者',
  avatarUrl: '',
  signature: '热爱生活，热爱音乐',
  followingCount: 128,
  followerCount: 256,
  likedSongsCount: 86,
  createdPlaylists: MOCK_PLAYLISTS.filter(p => p.isCreatedByUser),
  collectedPlaylists: MOCK_PLAYLISTS.filter(p => !p.isCreatedByUser && p.isCollected),
}

export function getSongById(id: string): Song | undefined {
  return MOCK_SONGS.find(s => s.id === id)
}

export function getPlaylistById(id: string): Playlist | undefined {
  return MOCK_PLAYLISTS.find(p => p.id === id)
}

export function getChartById(id: string): Chart | undefined {
  return MOCK_CHARTS.find(c => c.id === id)
}

export function getSongsByIds(ids: string[]): Song[] {
  const result: Song[] = []
  ids.forEach(id => {
    const song = getSongById(id)
    if (song !== undefined) {
      result.push(song)
    }
  })
  return result
}

export function getRecentSongs(): Song[] {
  return [MOCK_SONGS[0], MOCK_SONGS[6], MOCK_SONGS[2], MOCK_SONGS[16],
          MOCK_SONGS[9], MOCK_SONGS[3], MOCK_SONGS[11], MOCK_SONGS[18],
          MOCK_SONGS[4], MOCK_SONGS[7]]
}

export function getNewSongs(): Song[] {
  return [MOCK_SONGS[5], MOCK_SONGS[11], MOCK_SONGS[8], MOCK_SONGS[18],
          MOCK_SONGS[2], MOCK_SONGS[13], MOCK_SONGS[16], MOCK_SONGS[19]]
}

export function getRecommendedPlaylists(): Playlist[] {
  return [MOCK_PLAYLISTS[0], MOCK_PLAYLISTS[2], MOCK_PLAYLISTS[4], MOCK_PLAYLISTS[5],
          MOCK_PLAYLISTS[7], MOCK_PLAYLISTS[1]]
}

export function getPopularPlaylists(): Playlist[] {
  return [MOCK_PLAYLISTS[1], MOCK_PLAYLISTS[3], MOCK_PLAYLISTS[5], MOCK_PLAYLISTS[6],
          MOCK_PLAYLISTS[2], MOCK_PLAYLISTS[7], MOCK_PLAYLISTS[0], MOCK_PLAYLISTS[4]]
}

export function getSearchSuggestions(keyword: string): string[] {
  if (!keyword || keyword.length === 0) {
    return []
  }
  const k = keyword.toLowerCase()
  const allTerms: string[] = [
    ...MOCK_SONGS.map(s => s.name),
    ...MOCK_SONGS.map(s => s.artist),
    ...MOCK_PLAYLISTS.map(p => p.name),
  ]
  const deduped: string[] = []
  allTerms.forEach(t => {
    if (deduped.indexOf(t) === -1) {
      deduped.push(t)
    }
  })
  return deduped.filter(t => t.toLowerCase().includes(k)).slice(0, 8)
}

export function searchSongs(keyword: string): Song[] {
  if (!keyword) return []
  const k = keyword.toLowerCase()
  return MOCK_SONGS.filter(s =>
    s.name.toLowerCase().includes(k) || s.artist.toLowerCase().includes(k) || s.album.toLowerCase().includes(k)
  )
}

export function formatTime(ms: number): string {
  const totalSeconds = Math.floor(ms / 1000)
  const minutes = Math.floor(totalSeconds / 60)
  const seconds = totalSeconds % 60
  return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
}

export function formatPlayCount(count: number): string {
  if (count >= 10000000) {
    return `${(count / 10000000).toFixed(1)}亿`
  }
  if (count >= 10000) {
    return `${(count / 10000).toFixed(1)}万`
  }
  return count.toString()
}
