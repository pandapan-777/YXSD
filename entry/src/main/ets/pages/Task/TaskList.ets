import { getTaskListApi } from '../../api/task';
import { TaskListDataModel, TaskListItemDataModel, TaskListParamsModel, TaskTypeEnum } from '../../models/task';
import { TaskItemCard } from './TaskItemCard';

@Component
export struct TaskList {
  //保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  //任务列表传递的参数
  @State
  queryParams: TaskListParamsModel = {
    page: 1,
    pageSize: 5,
    status: TaskTypeEnum.Waiting
  }
  //初始化一个变量保存请求的状态,false未上拉加载，true上拉加载中
  @State
  loading: boolean = false
  //初始化一个变量，保存数据是否请求到
  @State
  finished: boolean = false
  //创建一个变量，保存下拉刷新的状态
  @State
  refreshIng: boolean = false
  @State
  refreshStatus: number = RefreshStatus.Inactive //默认为下拉状态

  aboutToAppear(): void {
    //调用获取任务列表数据方法
    this.onLoading()
  }

  //获取任务列表数据


  //请求任务列表数据的方法
  async onLoading(flag?: boolean) {
    //请求任务列表数据
    try {
      //请求状态修改为上拉加载
      this.loading = true

      const res: TaskListDataModel = await getTaskListApi(this.queryParams)

      if (flag) {
        this.taskList = res.items
      } else {
        this.taskList.push(...res.items)
      }

      //如果当前数据页码大于总页码，就返回true
      if (this.queryParams.page >= res.pages) {
        this.finished = true
      }
      // flag?this.taskList=res.items: this.taskList.push(...res.items) //在原来基础上数据可以追加
      //页码++
      this.queryParams.page++

      //上拉加载已结束
      this.loading = false
    } catch (e) {
      console.log(e);
    }
  }

  @Builder
  getBottom() {
    Row() {
      if (this.finished) {
        Text("没有更多数据了...")
          .fontSize(12)
          .fontColor($r("app.color.text_secondary"))
      } else {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r("app.color.text_secondary"))

        Text("拼命加载中")
          .fontSize(12)
          .fontColor($r("app.color.text_secondary"))
      }

    }.width("100%")
    .justifyContent(FlexAlign.Center)
    .padding(10)
  }

  @Builder
  getRefreshBuilder() {
    Row() {
      LoadingProgress()
        .width(40)
        .aspectRatio(1)
        .color($r("app.color.primary"))

      Text(this.getRefreshText())
        .fontSize(14)
        .fontColor($r("app.color.text_secondary"))
    }
    .width("100%")
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  getRefreshText() {
    //下拉距离小于刷新距离，提示文本为继续下拉

    //如果下拉距离超过刷新距离，松手刷新

    //如果当前状态刷新中：正在刷新
    switch (this.refreshStatus) {
      case RefreshStatus.Inactive:
        return ""
      case RefreshStatus.Drag:
        return "继续下拉"
      case RefreshStatus.OverDrag:
        return "松手刷新"
      case RefreshStatus.Refresh:
        return "正在刷新"
      default:
        return ""
    }
  }

  //下拉刷新的方法
  async onRefresh() {
    this.queryParams.page = 1
    this.finished = false
    await this.onLoading()
  }

  build() {
    Refresh({ refreshing: $$this.refreshIng, builder: this.getRefreshBuilder }) {
      List({ space: 10 }) {

        ForEach(this.taskList, (item: TaskListItemDataModel) => {

          ListItem() {
            TaskItemCard({
              taskItem: item
            })
          }
        })

        ListItem() {
          this.getBottom()
        }
      }
      .width("100%")
      .height("100%")
      .backgroundColor($r("app.color.background_page"))
      .padding(15)
      .onReachEnd(() => {

        //滚动到底部的方法
        if (this.loading) {
          return
        }

        if (this.finished) {
          return
        }
        this.onLoading()
      })

    }
    //下拉刷新状态发生变化的时候触发
    .onStateChange((state) => {
      this.refreshStatus = state
      if (this.refreshStatus === RefreshStatus.Refresh) {
        this.onRefresh()
        this.refreshIng = false
      }
    })
  }
}