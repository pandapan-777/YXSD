import { ICard, ICardItem } from 'basic';
import { getUserInfoApi, getUserTaskInfoApi } from '../../api';
import { UserInfoModel, UserTaskInfoModel, UserTaskInfoParamsModel } from '../../models';
import { router } from '@kit.ArkUI';
import { my_skeleton } from './Skeleton/my_skeleton';

@Entry
@Component
export struct My {
  @State userInfo: UserInfoModel = {} as UserInfoModel
  @Consume @Watch("initUserInfo") currentName: string
  //定义获取任务数据的方法
  @State
  queryTaskParms: UserTaskInfoParamsModel = {
    month: (new Date().getMonth() + 1).toString(),
    year: new Date().getFullYear().toString(),
  }
  //初始化一个变量，用来保存请求的任务数据
  @State
  userTaskInfo: UserTaskInfoModel = {} as UserTaskInfoModel
  @State
  loading: boolean = false

  //调用获取用户信息接口
  aboutToAppear(): void {
    this.initUserInfo()
  }

  //获取用户信息方法
  async getUserInfo() {
    try {

      this.userInfo = await getUserInfoApi()


    } catch (e) {
      console.log(e)
    }
  }

  //当进入我的页面的时候就会触发的方法
  async initUserInfo() {
    this.loading = true
    await this.getUserInfo()
    await this.getUserTaskInfo()
    this.loading = false
  }

  //获取任务数据的方法
  async getUserTaskInfo() {
    try {
      this.userTaskInfo = await getUserTaskInfoApi(this.queryTaskParms)

    } catch (e) {
      console.log(e)
    }
  }

  build() {
    Column() {
      if (this.loading && !this.userInfo.name && !this.userTaskInfo.taskAmounts) {
        my_skeleton()
      } else {
        Column() {

          //用户信息
          Column() {

            Image(this.userInfo.avatar ? this.userInfo.avatar : $r("app.media.ic_avatar_driver"))
              .width(67)
              .height(67)
              .borderRadius(33.5)
            // .backgroundColor(Color.White)

            Text(this.userInfo.name ? this.userInfo.name : "")
              .fontSize(18)
              .fontWeight(400)
              .lineHeight(20)
              .margin({ top: 9, bottom: 9 })
              .fontColor($r("app.color.white"))


            Text("司机编号: " + (this.userInfo.number ? this.userInfo.number : ""))
              .fontSize(14)
              .fontWeight(400)
              .lineHeight(20)
              .fontColor($r("app.color.white"))

            Text("手机号码: " + (this.userInfo.phone ? this.userInfo.phone : ""))
              .fontSize(14)
              .fontWeight(400)
              .lineHeight(20)
              .fontColor($r("app.color.white"))

          }
          .width("100%")
          .height(292)
          .backgroundImage($r("app.media.bg_page_my"))
          .backgroundImageSize(ImageSize.Cover)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          //本月任务
          Column() {
            Text("- 本月任务 -")
              .fontSize(14)
              .fontColor($r("app.color.text_secondary"))
              .lineHeight(20)
              .margin({ top: 10 })

            Row() {
              Column({ space: 15 }) {
                Text(this.userTaskInfo.taskAmounts?.toString() || '')
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)

                Text("任务总量")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
              }

              Column({ space: 15 }) {
                Text(this.userTaskInfo.completedAmounts?.toString() || "")
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)

                Text("完成任务量")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
              }

              Column({ space: 15 }) {
                Text(this.userTaskInfo.transportMileage?.toString() || '')
                  .fontSize(18)
                  .fontColor($r("app.color.text_primary"))
                  .lineHeight(25)

                Text("运输里程(km)")
                  .fontSize(12)
                  .fontColor($r("app.color.text_primary"))
              }

            }.width("100%")
            .justifyContent(FlexAlign.SpaceAround)
            .layoutWeight(1)
          }.backgroundColor($r("app.color.white"))
          .height(134)
          .margin({
            left: 10,
            right: 10,
            top: -55,
            bottom: 15
          })
          .borderRadius(8)


          //选项列表
          ICard() {
            //尾随闭包的写法
            ICardItem({
              leftText: "车辆信息"
            })
            ICardItem({
              leftText: "任务数据"
            })
            ICardItem({
              leftText: "系统设置",
              onRightClick: () => {
                router.pushUrl({
                  url: "pages/Setting/Setting"
                })
              }
            })
          }

        }.backgroundColor($r("app.color.background_page"))
        .height('100%')
        .width('100%')
      }
    }
    .height('100%')
    .width('100%')
  }
}