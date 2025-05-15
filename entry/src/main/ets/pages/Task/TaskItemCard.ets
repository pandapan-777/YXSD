import { TaskListItemDataModel } from '../../models/task'
import { router } from '@kit.ArkUI'

@Preview
@Component
export struct TaskItemCard {
  @Prop
  taskItem: TaskListItemDataModel = {} as TaskListItemDataModel

  toPickUp(){
    router.pushUrl({
      url:"pages/TaskDetail/TaskDetail",
      params:{
        id:this.taskItem.id
      }
    })
  }

  build() {
    Column() {
      Row() {
        //任务编号
        Text("任务编号：" + this.taskItem.transportTaskId)
          .fontSize(16)
          .fontColor($r("app.color.text_primary"))
          .lineHeight(22)
          .fontWeight(500)
        //以延迟
        // Text("以延迟")


      }.width("100%")
      .justifyContent(FlexAlign.SpaceBetween)


      //起点和终点地址
      Row() {
        Text("起")
          .width(22)
          .height(22)
          .backgroundColor($r("app.color.text_primary"))
          .fontColor($r("app.color.white"))
          .borderRadius(11)
          .textAlign(TextAlign.Center)


        Text(this.taskItem.startAddress)
          .fontSize(14)
          .fontColor($r("app.color.text_secondary"))
          .margin({ left: 12 })
      }
      .width("100%")
      .margin({
        top: 20
      })
      .alignItems(VerticalAlign.Center)


      Row() {
        Text("止")
          .width(22)
          .height(22)
          .backgroundColor($r("app.color.primary"))
          .fontColor($r("app.color.white"))
          .borderRadius(11)
          .textAlign(TextAlign.Center)


        Text(this.taskItem.endAddress)
          .fontSize(14)
          .fontColor($r("app.color.text_secondary"))
          .margin({ left: 12 })
      }
      .width("100%")
      .margin({
        top: 20
      })
      .alignItems(VerticalAlign.Center)


      Divider()
        .strokeWidth(3)
        .color($r("app.color.background_divider"))
        .margin({
          top: 20,
          bottom: 20
        })

      //提货时间
      Row() {
        Column({ space: 5 }) {
          Text("提货时间")
            .fontColor($r("app.color.text_secondary"))
            .fontSize(14)

          Text(this.taskItem.planDepartureTime)
            .fontColor($r("app.color.text_primary"))

        }.alignItems(HorizontalAlign.Start)

        Button("提货", { type: ButtonType.Capsule })
          .backgroundColor(this.taskItem.enablePickUp ? $r("app.color.primary") : $r("app.color.primary_disabled"))
          .fontColor($r("app.color.white"))
          .fontSize(14)
          .enabled(this.taskItem.enablePickUp)
          .height(32)

      }.width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width("100%")
    .backgroundColor($r("app.color.white"))
    .borderRadius(10)
    .padding(20)
    .onClick(()=>{
      this.toPickUp()
    })

  }
}