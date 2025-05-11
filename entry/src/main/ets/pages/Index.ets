import { TabClass } from 'basic'
import { Message } from './view/Message'
import { My } from './view/My'
import { Task } from './view/Task'

@Entry
@Component
struct Index {
  @State TabBarInfo: TabClass[] = [
    {
      name: "任务",
      icon: $r("app.media.ic_tab_btn_task"),
      title: "task"
    },
    {
      name: "消息",
      icon: $r("app.media.ic_tab_btn_mess_nor"),
      title: "message"
    },
    {
      name: "我的",
      icon: $r("app.media.ic_tab_btn_mine_nor"),
      title: "my"
    }
  ]
  @Watch("updateName")
  @State currentIndex: number = 0

  @Provide currentName:string="task"
  //监听·TabBar下标的方法
  updateName(){
    this.currentName=this.TabBarInfo[this.currentIndex].name
  }

  @Builder
  getTabBar(item: TabClass) {
    Column({ space: 10 }) {
      Image(item.icon)
        .width(22)
        .height(22)
        .fillColor(item.title === this.TabBarInfo[this.currentIndex].title ? $r("app.color.primary") :
        $r("app.color.text_secondary"))

      Text(item.name)
        .fontSize(12)
        .fontWeight(400)
        .margin({
          top: 5
        })
        .fontColor(item.title === this.TabBarInfo[this.currentIndex].title ? $r("app.color.primary") :
        $r("app.color.text_secondary"))

    }
  }

  build() {

    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }) {
        ForEach(this.TabBarInfo, (item: TabClass) => {
          TabContent() {
            if (item.title === "task") {
              Task()
            } else if (item.title === "message") {
              Message()
            } else if(item.title==="my"){
              My()
            }

          }.tabBar(this.getTabBar(item))
        })

      }
      .animationDuration(300)

    }
    .height('100%')
    .width('100%')
  }
}