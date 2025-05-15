import { router } from '@kit.ArkUI'

@Component
export struct INavBar {
  @State title: string = ""
  showBackIcon: boolean = true
  backIcon: ResourceStr = $r("app.media.ic_btn_nav_back")
  rightText: string = ""

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Row() {
          if (this.title) {
            Text(this.title)
              .fontColor($r("app.color.text_primary"))
              .fontSize(18)
              .fontWeight(600)
          }

        }.width("100%")
        .height("100%")
        .justifyContent(FlexAlign.Center)


        if (this.rightText) {
          Row() {
            Text(this.rightText)
              .fontSize(14)
          }.width("100%")
          .justifyContent(FlexAlign.End)
          .margin({ top: 15 })
          .padding({ right: 10 })
        }


        if (this.showBackIcon) {
          Image(this.backIcon)
            .width(44)
            .aspectRatio(1)
            .onClick(() => {
              router.back()
            })
        }


      }.width("100%")
      .height(50)
      .backgroundColor($r("app.color.white"))
    }
  }
}