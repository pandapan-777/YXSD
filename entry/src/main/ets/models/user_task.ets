
//任务数据接口请求的参数
export interface UserTaskInfoParamsModel{
  //月
  month:string;

  //年
  year:string;
}

//任务数据接口后端返回的数据类型
export interface UserTaskInfoModel{
  //完成任务数量，基于实际完成时间统计
  completedAmounts:number;

  //每日里程，基于实际完成时间统计
  dailyMileage:DailyMileageModel[];

  //任务数量，基于实际完成时间统计
  taskAmounts:number;

  //运输里程，单位：公里，基于实际完成时间统计
  transportMileage:number;

}

export interface DailyMileageModel{
  //日期
  dateTime?:string;
  //公里，单位：公里;计算单位：原始数据
  mileage?:number
}
