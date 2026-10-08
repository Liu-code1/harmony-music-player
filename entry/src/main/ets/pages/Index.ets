import { Colors, Dimensions } from '../common/Constants'
import { PlayerViewModel } from '../viewmodel/PlayerViewModel'
import { TabBar } from '../components/TabBar'
import { MiniPlayer } from '../components/MiniPlayer'
import { HomePage } from './HomePage'
import { SearchPage } from './SearchPage'
import { LibraryPage } from './LibraryPage'
import { ProfilePage } from './ProfilePage'
import router from '@ohos.router'

/**
 * Main entry page — Tab container with bottom navigation.
 * Provides PlayerViewModel via @Provide for all child pages/components.
 */
@Entry
@Component
struct Index {
  private playerVM: PlayerViewModel = PlayerViewModel.getInstance()
  @State currentTab: number = 0
  private tabController: TabsController = new TabsController()

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // ---- Tab content ----
      Tabs({ index: this.currentTab, controller: this.tabController }) {
        TabContent() {
          HomePage()
        }

        TabContent() {
          SearchPage()
        }

        TabContent() {
          LibraryPage()
        }

        TabContent() {
          ProfilePage()
        }
      }
      .barHeight(0)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentTab = index
      })
      .width('100%')
      .height('100%')

      // ---- Mini player + Tab bar overlay at bottom ----
      Column() {
        // Mini player above tab bar (shown when song is playing)
        MiniPlayer({
          onOpenPlayer: () => {
            router.pushUrl({ url: 'pages/PlayerPage' })
          }
        })

        // Bottom tab bar
        TabBar({
          currentTab: this.currentTab,
          onTabChange: (index: number) => {
            this.currentTab = index
            this.tabController.changeIndex(index)
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
