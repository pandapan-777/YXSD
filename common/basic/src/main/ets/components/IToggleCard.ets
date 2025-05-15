@Component
export struct IToggleCard {
  @State toggleCard: boolean = true
  @State title: string = "基本信息"
  @BuilderParam
  CardContent: () => void

  build() {
    Column() {
      Row() {
        Text(this.title)
          .fontSize(16)
          .fontColor($r("app.color.text_primary"))
          .fontWeight(600)

        Image(this.toggleCard ? $r("app.media.ic_btn_cut") : $r("app.media.ic_btn_add"))
          .width(24)
          .aspectRatio(1)
          .onClick(() => {
            animateTo({ duration: 300 }, () => {
              this.toggleCard = !this.toggleCard
            })
          })
      }.width("100%")
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.toggleCard && this.CardContent) {
        this.CardContent()
      }
    }
    .backgroundColor($r("app.color.white"))
    .padding(18)
    .borderRadius(10)
    .margin({
      left: 18,
      top: 18,
      right: 18
    })
  }
}