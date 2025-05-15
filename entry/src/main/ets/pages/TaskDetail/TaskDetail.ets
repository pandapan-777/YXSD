import { router } from '@kit.ArkUI'
import { INavBar, IToggleCard, RouterParamsModel } from 'basic'
import { getTaskDetailInfoApi } from '../../api/task_detail'
import { TaskDetailInfoModel } from '../../models'

@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel
  @State
  taskDetailInfo: TaskDetailInfoModel = {} as TaskDetailInfoModel

  aboutToAppear(): void {
    this.getParamsData()
    this.getTaskDetail()
  }

  @Builder
  getBaseContentItem(item: BaseBuilderClass) {
    Row() {
      Text(item.title).fontSize(14).fontColor($r("app.color.text_secondary"))
        .lineHeight(20)

      Row() {
        Text(item.value).fontSize(14).fontColor($r("app.color.text_secondary"))
        if (item.icon) {
          Image(item.icon).width(24).height(24)
        }
      }
    }.justifyContent(FlexAlign.SpaceBetween).width("100%").margin({
      top: 14
    })

  }

  //基本信息
  @Builder
  getBaseContent() {
    Row() {
      Column() {
        Row() {
          Text("起").baseTextIconStyle()
          Text("jgcdskagyurfewish").baseTextStyle()
        }.margin({ top: 21 })

        Row() {
          Text("止").baseTextIconStyle().backgroundColor($r("app.color.primary"))
          Text("jgcdskagyurfewish").baseTextStyle()
        }.margin({ top: 21 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ right: 20 })

      Column() {
        Image($r("app.media.ic_navigation")).width(30)
        Text("开始导航").fontSize(14).margin({ top: 20, bottom: 20 })
      }.justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: 20
      })

    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width("100%")

    Divider()
      .vertical(false)
      .height(2)
      .color($r("app.color.background_divider"))
      .margin({ left: 8, right: 8, top: 21 })

    this.getBaseContentItem({
      title: "联系人",
      value: "张三"
    })

    this.getBaseContentItem({
      title: "联系电话",
      value: "r4675423134567",
      icon: $r("app.media.ic_phone")
    })

    this.getBaseContentItem({
      title: "提货时间",
      value: "r4675423134567",
    })

    this.getBaseContentItem({
      title: "预计送达时间",
      value: "r4675423134567",

    })

  }

  //车辆司机信息
  @Builder
  getDriverConTent() {
    Column({ space: 20 }) {
      Row() {
        Text("车牌号").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
        Text("京A5643768").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
      }.justifyContent(FlexAlign.SpaceBetween).width("100%")

      Row() {
        Text("司机姓名").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
        Text("张三").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
      }.justifyContent(FlexAlign.SpaceBetween).width("100%")
    }.padding({ right: 10, left: 10, top: 10 })

  }

  //运输路线
  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text("北京市").fontSize(16).fontColor($r("app.color.text_primary")).lineHeight(22)
        Text("北京市").fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text("河南省").fontSize(16).fontColor($r("app.color.text_primary"))
        Text("郑州市").fontSize(14).lineHeight(22)
      }.width(50)
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width("100%")
    .padding({
      left: 60,
      right: 60,
      top: 20,
      bottom: 20
    })
  }

  //获取任务页面传递过来的司机Id
  getParamsData() {
    this.params = router.getParams() as RouterParamsModel
    //router.getParams()
  }

  //获取任务详情的数据
  async getTaskDetail() {
    try {
      this.taskDetailInfo = await getTaskDetailInfoApi(this.params.id)

    } catch (e) {
      console.log("error", e)
    }
  }

  build() {
    Column() {
      INavBar({
        title: "任务详情",
        rightText: "取消任务"
      })
      Scroll() {
        Column() {
          IToggleCard() {
            this.getBaseContent()
          }

          IToggleCard({
            title: "车辆司机信息",
            toggleCard: false
          }) {
            this.getDriverConTent()
          }

          IToggleCard({
            title: "运输路线",
            toggleCard: false
          }) {
            this.getTransLineContent()
          }

          IToggleCard({
            title: "物品信息",
            toggleCard: false
          })
          IToggleCard({
            title: "提供信息",
            toggleCard: false
          })
        }
        .padding({
          bottom: 50
        })
        .height("100%")
      }.height("100%")
      .backgroundColor($r("app.color.background_page"))
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))
  }
}

@Extend(Text)
function baseTextIconStyle() {
  .fontSize(12)
  .fontColor($r("app.color.white"))
  .backgroundColor($r("app.color.text_primary"))
  .width(22)
  .height(22)
  .borderRadius(11)
  .textAlign(TextAlign.Center)
}

@Extend(Text)
function baseTextStyle() {
  .margin({ left: 11.5 })
  .fontColor($r("app.color.text_secondary"))
  .fontSize(14)
  .lineHeight(20)
}

interface BaseBuilderClass {
  title: string
  value: string
  icon?: ResourceStr
}