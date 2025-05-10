import { LoginApi } from '../../api'
import { AccountForModel } from '../../models'
import { promptAction, router } from '@kit.ArkUI'
import { UserSettingClass } from 'basic'

@Entry
@Component
struct Login {
  //登录加载
  @State LoadingLogin: boolean = false
  @State
  accountForm: AccountForModel = {
    account: '',
    password: ''
  }

  async submitLogin() {
    this.LoadingLogin = true

    try {
      const res = await LoginApi(this.accountForm)
      //TODO 将token存储到本地
      const setting=new UserSettingClass(getContext())
      setting.setUserToken(res)

      //TODO 跳转到首页
      router.pushUrl({
        url: "pages/Index"
      })
    } catch (e) {
      console.log(e);
    } finally {
      this.LoadingLogin = false
    }
  }

  getFormValidate() {
    if (this.accountForm.account && this.accountForm.password) {
      return true
    } else {
      return false
    }
  }

  @Styles
  LoginStyles(){
    .backgroundColor("#fff")
    .height(58)
    .border({
      width: {
        bottom: 1
      },
      color: $r("app.color.background_divider")
    }).borderRadius(0)
  }

  build() {
    Column() {
      //顶部标题

      Text("神领快递")
        .width("100%")
        .fontSize(20)
        .fontColor($r("app.color.text_primary"))
        .margin({ top: 30, bottom: 30 })
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
      //登录账号标题
      Row() {
        Text("账号登录")
          .fontSize(24)
          .fontWeight(600)

        Row() {
          Text("手机号登录").fontColor($r("app.color.primary"))
            .fontSize(15)
            .fontWeight(600)
          Image($r("app.media.ic_angle"))
            .width(10)
            .height(10)
            .margin({ left: 5 })
        }

      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 50, bottom: 50 })

      //账号输入框标题
      TextInput({ placeholder: "请输入账号", text: $$this.accountForm.account })
        .LoginStyles()

      //密码输入框
      TextInput({ placeholder: "请输入密码", text: $$this.accountForm.password })
        .LoginStyles()
        .type(InputType.Password)


      //登录按钮
      Button({ type: ButtonType.Capsule }) {
        Row({ space: 10 }) {
          if (this.LoadingLogin) {
            LoadingProgress()
              .width(20)
              .height(20)
          }

          Text("登录")
            .fontColor($r("app.color.white"))
        }
      }
      .width("100%")
      .height(50)
      .backgroundColor(this.getFormValidate() ? $r("app.color.primary") : $r("app.color.primary_disabled"))
      .margin({ top: 50 })
      .enabled(this.getFormValidate() ? true : false)
      .onClick(() => {
        this.submitLogin()
      })

    }
    .width('100%')
    .padding({
      left: 32,
      right: 32
    })
    .margin({ top: 40 })
  }
}