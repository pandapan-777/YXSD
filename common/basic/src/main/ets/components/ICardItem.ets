@Component
export struct ICardItem {
  leftText: string = ""
  showRightIcon: boolean = true
  RightIcon: ResourceStr = $r("app.media.ic_btn_more")
  @Prop
  RightText: string = ""
  showBottomBorder: boolean = true
  onRightClick: () => void = () => {
  }

  build() {
    Row() {
      Text(this.leftText)
        .fontSize(14)
        .fontWeight(400)
        .fontColor($r("app.color.text_primary"))

      Row({ space: 5 }) {
        if (this.RightText) {
          Text(this.RightText)
            .fontSize(16)
            .fontWeight(400)
            .fontColor($r("app.color.text_primary"))

        }

        if (this.showRightIcon === true) {
          Image(this.RightIcon)
            .width(24)
            .height(24)
        }
      }
      .onClick(() => {
        this.onRightClick()
      })

    }
    .width("100%")
    .height(60)
    .border({
      width: {
        bottom: this.showBottomBorder ? 1 : 0
      },
      color: $r("app.color.background_divider")
    })
    .justifyContent(FlexAlign.SpaceBetween)

  }
}