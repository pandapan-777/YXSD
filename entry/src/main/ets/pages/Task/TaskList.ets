import { IList } from 'basic';
import { getTaskListApi } from '../../api/task';
import { TaskListDataModel, TaskListItemDataModel, TaskListParamsModel, TaskTypeEnum } from '../../models/task';
import { TaskItemCard } from './TaskItemCard';

@Component
export struct TaskList {
  //保存任务列表的数据
  @State
  taskList: TaskListItemDataModel[] = []
  //任务列表传递的参数
  @Prop
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
  //请求任务列表数据的方法
  onLoad = async (flag?: boolean) => {
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
  //获取任务列表数据
  //下拉刷新的方法
  onRefresh = async () => {
    this.queryParams.page = 1
    this.finished = false
    await this.onLoad()
  }

  aboutToAppear(): void {
    //调用获取任务列表数据方法
    this.onLoad()
  }

  @Builder
  renderItem(item: object) {
    TaskItemCard({
      taskItem: item as TaskListItemDataModel
    })

  }

  build() {
    IList({
      finishedText: "没有更多数据了",
      loadingText: "加载中",
      dataSource: this.taskList,
      renderItem: this.renderItem,
      onLoad: this.onLoad,
      finished: this.finished,
      onRefresh: this.onRefresh,
      loading: this.loading,
      refreshIng: this.refreshIng
    })
  }
}