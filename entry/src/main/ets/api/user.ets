import { Http } from 'basic'
import { AccountForModel, UserInfoModel } from '../models'

//登录接口
export const LoginApi = (data: AccountForModel): Promise<string> => {
  return Http.post<string>("/login/account", data)
}

//获取用户信息接口
export const getUserInfoApi=():Promise<UserInfoModel>=>{
  return Http.get<UserInfoModel>("/users")
}

//退出登录接口
