import { Http } from 'basic'
import { AccountForModel, UserInfoModel, UserTaskInfoModel, UserTaskInfoParamsModel } from '../models'

//登录接口
export const LoginApi = (data: AccountForModel): Promise<string> => {
  return Http.post<string>("/login/account", data)
}

//获取用户信息接口
export const getUserInfoApi=():Promise<UserInfoModel>=>{
  return Http.get<UserInfoModel>("/users")
}


//获取任务数据接口
export const getUserTaskInfoApi=(params:UserTaskInfoParamsModel):Promise<UserTaskInfoModel>=>{
  return Http.get<UserTaskInfoModel>("/users/taskReport",params)
}

//退出登录接口
