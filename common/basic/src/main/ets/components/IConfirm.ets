import { CustomDialogModel } from '../models'


@CustomDialog
@Component
export struct IConfirm {
  controller: CustomDialogController
  message: string = ""
  buttonList: CustomDialogModel[] = []

  build() {

    Row() {
      Column() {
        Row() {
          Text(this.message)
            .fontSize(16)
            .fontColor($r("app.color.text_primary"))
            .fontWeight(500)
        }.width("100%")
        .height(88)
        .justifyContent(FlexAlign.Center)
        .border({
          width: {
            bottom: 1
          },
          color: $r("app.color.background_divider")
        })


        Row() {
          ForEach(this.buttonList, (item: CustomDialogModel, index: number) => {
            Text(item.text)
              .fontSize(item.fontSize || 16)
              .fontColor(item.fontColor || $r("app.color.text_secondary"))
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height("100%")
              .border({
                width: {
                  right: this.buttonList.length > 1 && index !== this.buttonList.length - 1 ? 1 : 0
                }, color: $r("app.color.background_divider")
              })
              .onClick(() => {
                if (item.action) {
                  item.action()
                }
                this.controller.close()
              })
          })


          // Text("确定")
          //   .fontSize(16)
          //   .fontColor($r("app.color.primary"))
          //   .textAlign(TextAlign.Center)
          //   .layoutWeight(1)
          //   .height("100%")
          // // .border({
          // //   width:{
          // //     right:1
          // //   },color:$r("app.color.background_divider")
          // // })

        }.width("100%")
        .height(49)

      }.width("100%")
      .backgroundColor($r("app.color.white"))
      .borderRadius(12)

    }.width("100%")
    .padding({
      left: 25,
      right: 25
    })

  }
}