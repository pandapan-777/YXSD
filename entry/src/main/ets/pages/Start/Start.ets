import { AdvertModel } from 'basic'

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

  //倒计时方法
  countDown() {
    this.timer = setInterval(() => {
      if (this.adObj.AdTime == 0) {
        //将方法释放了
        clearInterval(this.timer)
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
        .margin({ right: 20, top: 10 })
        .textAlign(TextAlign.Center)

    }
    .height('100%')
    .width('100%')
  }
}