import { ICard, ICardItem, IConfirm, UserSettingClass } from 'basic'
import { INavBar } from 'basic/src/main/ets/components/INavBar'
import { router } from '@kit.ArkUI'


@Entry
@Component
export struct Setting {
  //1.实例化对象
  controller: CustomDialogController = new CustomDialogController({
    builder: IConfirm({
      message: "确定要退出登录吗",
      buttonList: [
        {
          text: "取消"
        }, {
        text: "确定",
        fontColor: $r("app.color.primary"),
        action: () => {
          //调用退出登录接口
          this.logout()
        }
      }
      ]
    }),
    //4.去掉默认的弹窗样式
    customStyle: true
  })

  //2.定义弹窗的内容


  //退出登录
  logout() {
    //删除token
    const setting = new UserSettingClass(getContext())
    setting.deleteUserToken()
    //跳转到登录页
    router.replaceUrl({
      url: "pages/Login/Login"
    })
  }

  build() {
    Column() {

      //设置标题栏
      INavBar({
        title: "系统设置"
      }).margin({ bottom: 20 })


      //选项列表
      ICard() {
        ICardItem({
          leftText: "换绑手机"
        })
        ICardItem({
          leftText: "修改密码"
        })
        ICardItem({
          leftText: "消息通知设置"
        })
        ICardItem({
          leftText: "清理缓存"
        })
      }


      //退出按钮
      Row() {
        Button("退出", { type: ButtonType.Normal })
          .width("100%")
          .backgroundColor($r("app.color.white"))
          .fontColor($r("app.color.text_primary"))
          .height(60)
          .borderRadius(7)
          .onClick(() => {
            //3.打开弹窗
            this.controller.open()
          })

      }.width("100%")
      .padding({
        left: 15,
        right: 15
      })
      .margin({
        top: 20
      })

    }.height("100%")
    .width("100%")
    .backgroundColor($r("app.color.background_page"))
  }
}