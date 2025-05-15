import { Http } from 'basic';
import { TaskDetailInfoModel } from '../models';


//任务详情接口
export const getTaskDetailInfoApi = (jobId: string): Promise<TaskDetailInfoModel> => {
  return Http.get<TaskDetailInfoModel>(`/tasks/details/${jobId}`,)
}


