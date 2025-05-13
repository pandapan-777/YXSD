import { ISkeleton } from 'basic'

@Preview
@Component
export struct my_skeleton {
  build() {
    Column() {
      //用户信息
      Row() {
        ISkeleton({
          customWidth: "100%",
          customHeight: "100%",
          bdRadius:{
            bottomLeft:20,
            bottomRight:20
          }
        })
      }.width("100%")
      .height(370)


      //本月任务
      Row() {
        ISkeleton({
          customWidth: "100%",
          customHeight: "100%",
          bgColor: "#efefef",
          bdRadius:10
        })
      }
      .width("100%")
      .height(134)
      .padding({
        left: 15,
        right: 15
      })
      .margin({top:-20})


      //选项列表
      Column({space:3}){
        ISkeleton({
          customWidth: "100%",
          customHeight: 50,
          bdRadius:8
        })
        ISkeleton({
          customWidth: "100%",
          customHeight: 50,
          bdRadius:8
        })
        ISkeleton({
          customWidth: "100%",
          customHeight: 50,
          bdRadius:8
        })
      }.margin({top:20})
      .padding({left:15,right:15})

    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.white"))
  }
}