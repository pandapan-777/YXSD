@Entry
@Component
struct Start {
  @State message: string = 'Hello World';

  build() {
    Stack({alignContent:Alignment.TopEnd}){
      Image($r("app.media.start"))
        .objectFit(ImageFit.Cover)

      Text(`5秒后跳过`)
        .fontSize(12)
        .borderRadius(20)
        .height(30)
        .padding(8)
        .backgroundColor($r("app.color.background_page"))
        .margin({right:20,top:10})
        .textAlign(TextAlign.Center)

    }
    .height('100%')
    .width('100%')
  }
}