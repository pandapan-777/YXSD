
@Component
export struct ISkeleton {
  customWidth: number | string = ""
  customHeight: number | string = ""
  circle: boolean = false
  bgColor: string = "#f3f4f5"
  @State
  timer: number = -1
  bdRadius: number | string | BorderRadiuses = ""

  aboutToAppear(): void {
    this.splash()
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  splash() {
    this.timer = setInterval(() => {
      if (this.bgColor === "#f3f4f5") {
        this.bgColor = "#f7f8f9"
      } else {
        this.bgColor = "#f3f4f5"
      }
    }, 100)
  }

  build() {
    Row() {

    }
    .width(this.customWidth)
    .height(this.circle ? this.customHeight : this.customHeight)
    .borderRadius(this.circle ? this.customWidth : this.bdRadius)
    .backgroundColor(this.bgColor)

  }
}