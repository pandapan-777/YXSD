import { INavBar, ISkeleton } from 'basic'


@Preview
@Component
export struct TaskDetailSkeleton {
  build() {

    Column() {
      INavBar({ title: "任务详情", rightText: "取消任务" })
      Scroll() {
        Column({ space: 20 }) {
          ISkeleton({
            customWidth: "100%",
            customHeight: 320,
            bgColor: "#fff",
            bdRadius: 10
          })
          ISkeleton({
            customWidth: "100%",
            customHeight: 50,
            bgColor: "#fff",
            bdRadius: 10
          })
          ISkeleton({
            customWidth: "100%",
            customHeight: 50,
            bgColor: "#fff",
            bdRadius: 10
          })
          ISkeleton({
            customWidth: "100%",
            customHeight: 50,
            bgColor: "#fff",
            bdRadius: 10
          })
          ISkeleton({
            customWidth: "100%",
            customHeight: 50,
            bgColor: "#fff",
            bdRadius: 10
          })

        }
        .padding(20)
        .layoutWeight(1)

      }
      .layoutWeight(1)
      .backgroundColor($r("app.color.background_page"))

      ISkeleton({
        customWidth: "100%",
        customHeight: 60,
        bgColor: "#fff",
        bdRadius: 10
      })


    }
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.background_page"))

  }
}




