import { router } from '@kit.ArkUI'
import { BaseBuilderClass, INavBar, IToggleCard, IUpload, RouterParamsModel } from 'basic'
import { getTaskDetailInfoApi } from '../../api/task_detail'
import { TaskDetailInfoModel } from '../../models'
import { TaskDetailSkeleton } from './TaskDetailSkeleton/TaskDetailSkeleton'

@Entry
@Component
struct TaskDetail {
  @State
  params: RouterParamsModel = {} as RouterParamsModel
  @State
  taskDetailInfo: TaskDetailInfoModel = {} as TaskDetailInfoModel
  @State
  skeletonStatus: boolean = false

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
          Text(this.taskDetailInfo?.startAddress).baseTextStyle()
        }.margin({ top: 21 })

        Row() {
          Text("止").baseTextIconStyle().backgroundColor($r("app.color.primary"))
          Text(this.taskDetailInfo.endAddress).baseTextStyle()
        }.margin({ top: 21 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ right: 20 })

      //
      // Column() {
      //   Image($r("app.media.ic_navigation")).width(25)
      //   Text("开始导航").fontSize(14).margin({ top: 20, bottom: 20 })
      // }.justifyContent(FlexAlign.SpaceBetween)
      // .margin({
      //   top: 20
      // })

    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width("100%")

    Divider()
      .vertical(false)
      .height(2)
      .color($r("app.color.background_divider"))
      .margin({ left: 8, right: 8, top: 21 })

    this.getBaseContentItem({
      title: "任务编号",
      value: this.taskDetailInfo.transportTaskId
    })
    this.getBaseContentItem({
      title: "联系人",
      value: this.taskDetailInfo.startHandoverName
    })

    this.getBaseContentItem({
      title: "联系电话",
      value: this.taskDetailInfo.startHandoverPhone,
      icon: $r("app.media.ic_phone")
    })

    this.getBaseContentItem({
      title: "提货时间",
      value: this.taskDetailInfo.planDepartureTime
    })

    this.getBaseContentItem({
      title: "预计送达时间",
      value: this.taskDetailInfo.planArrivalTime
    })

  }

  //车辆司机信息
  @Builder
  getDriverConTent() {
    Column({ space: 20 }) {
      Row() {
        Text("车牌号").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
        Text(this.taskDetailInfo.licensePlace).fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
      }.justifyContent(FlexAlign.SpaceBetween).width("100%")

      Row() {
        Text("司机姓名").fontSize(14).fontColor($r("app.color.text_secondary"))
          .lineHeight(20)
        Text(this.taskDetailInfo.driverName).fontSize(14).fontColor($r("app.color.text_secondary"))
      }.justifyContent(FlexAlign.SpaceBetween).width("100%")
    }.padding({ right: 10, left: 10, top: 10 })

  }

  //运输路线
  @Builder
  getTransLineContent() {
    Row() {
      Column() {
        Text(this.taskDetailInfo.startProvince).fontSize(16).fontColor($r("app.color.text_primary")).lineHeight(22)
        Text(this.taskDetailInfo.startCity).fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text(this.taskDetailInfo.endProvince).fontSize(16).fontColor($r("app.color.text_primary"))
        Text(this.taskDetailInfo.endCity).fontSize(14).lineHeight(22)
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
      this.skeletonStatus = true
      this.taskDetailInfo = await getTaskDetailInfoApi(this.params.id)
      this.skeletonStatus = false

    } catch (e) {
      console.log("error", e)
    }
  }

  //底部布局
  @Builder
  getBottomBtn() {
    Row() {
      Button("延迟收货", { type: ButtonType.Capsule })
        .width(125)
        .height(50)
        .fontSize(16)
        .backgroundColor($r("app.color.btn_gray"))
        .fontColor($r("app.color.text_primary"))
      Button("提货")
        .layoutWeight(1)
        .height(50)
        .fontSize(16)
        .fontColor($r("app.color.white"))
        .backgroundColor($r("app.color.primary_disabled"))
        .margin({ left: 13 })
    }
    .width("100%")
    .height(70)
    .padding({ left: 15, right: 15 })
    .backgroundColor($r("app.color.white"))
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    if (this.skeletonStatus) {
      TaskDetailSkeleton()
    } else {
      Column() {
        INavBar({ title: "任务详情", rightText: "取消任务" })
        Scroll() {
          Column() {
            IToggleCard() {
              this.getBaseContent()
            }

            IToggleCard({ title: "车辆司机信息", toggleCard: false }) {
              this.getDriverConTent()
            }

            IToggleCard({ title: "运输路线", toggleCard: false }) {
              this.getTransLineContent()
            }

            IToggleCard({ title: "物品信息", toggleCard: false })
            IToggleCard({ title: "提供信息", toggleCard: false }) {
              IUpload({ title: "请拍照上传回单凭证" })
              IUpload({ title: "请拍照上传货品照片" })
            }
          }
          .padding({ bottom: 20 })
        }
        .layoutWeight(1)
        .backgroundColor($r("app.color.background_page"))


        //底部
        this.getBottomBtn()
      }
      .height('100%')
      .width('100%')
      .backgroundColor($r("app.color.background_page"))
    }

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



