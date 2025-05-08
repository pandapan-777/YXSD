import { AdvertModel } from 'basic'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Start {
  @State
  adObj: AdvertModel = {
    ShowAd: false,
    AdTime: 5,
    AdUrl: '',
    ImageAd: ''
  }
  @State timer: number = -1

  aboutToAppear(): void {
    this.countDown()
  }

  //销毁子窗口
  closeWin() {
    //找到子窗口
    //清除子窗口
    window.findWindow("ad_window").destroyWindow()
  }

  //倒计时方法
  countDown() {
    this.timer = setInterval(() => {
      //倒计时为零后
      if (this.adObj.AdTime == 0) {
        //清除定时器
        clearInterval(this.timer)
        //销毁子窗口
        this.closeWin()
        //阻止代码往下执行
        return
      }
      this.adObj.AdTime--
    }, 1000)
  }

  //当页面销毁时，一定要清除定时器，如果不清除，内存会泄露
  aboutToDisappear(): void {
    //清除定时器
    clearInterval(this.timer)
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r("app.media.start"))
        .objectFit(ImageFit.Cover)

      Text(`${this.adObj.AdTime}秒后跳过`)
        .fontSize(12)
        .borderRadius(20)
        .height(30)
        .padding(8)
        .backgroundColor($r("app.color.background_page"))
        .margin({ right: 20, top: 30 })
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.closeWin()
        })

    }
    .height('100%')
    .width('100%')
  }
}