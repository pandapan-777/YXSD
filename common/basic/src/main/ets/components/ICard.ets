@Component
export struct ICard {
  @BuilderParam
  ICardFn: () => void

  build() {
    Column() {
      if (this.ICardFn) {
        this.ICardFn()
      }
    }.borderRadius(8)
    .backgroundColor($r("app.color.white"))
    .padding({ left: 18, right: 18 })
    .margin({
      left: 15, right: 15
    })
  }
}