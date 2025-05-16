import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { ImageListModel } from '../models'
import { IPreview } from './IPreview'


@Component
export struct IUpload {
  @Prop title: string = "请拍照上传照片"
  @State imageList: ImageListModel[] = []
  @Prop maxNumber: number = 3
  @State index: number = 0
  customDialogController: CustomDialogController = new CustomDialogController({
    builder: IPreview({
      urls: this.imageList.map((item: ImageListModel) => item.url),
      selectIndex: this.index
    }),
    customStyle: true

  })

  //唤醒相机方法
  async selectImage() {
    //1.创建图库的选择器实例
    const photoViewPicker = new photoAccessHelper.PhotoViewPicker
    //2.打开系统相册
    const result = await photoViewPicker.select({
      maxSelectNumber: this.maxNumber - this.imageList.length,
      MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE
    })
    //3.将上传的图片保存imageList里面
    const data = result.photoUris.map((item: string) => {
      return { url: item } as ImageListModel
    })
    this.imageList.push(...data)
  }

  build() {
    Column() {
      if (this.title) {
        Text(this.title)
          .fontSize(14)
          .fontWeight(400)
          .fontColor($r("app.color.text_secondary"))
          .margin({
            top: 16,
            bottom: 16
          })
      }
      Grid() {
        ForEach(this.imageList, (item: ImageListModel, index: number) => {
          GridItem() {
            Image(item.url)
              .width(95)
              .height(95)
              .borderRadius(5)
              .onClick(() => {
                //点击照片
                this.customDialogController.open()
                this.index = index
              })
          }
        })
        if (this.imageList.length < this.maxNumber) {
          GridItem() {
            Row() {

              Image($r("app.media.ic_add_img"))
                .width(30)
                .height(30)
            }
            .width(95)
            .height(95)
            .backgroundColor("#F2F2F2")
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectImage()
            })
          }
        }
      }
      .columnsGap(10)
      .rowsGap(10)
      .columnsTemplate("1fr 1fr 1fr")

    }.width("100%")
    .alignItems(HorizontalAlign.Start)
  }
}