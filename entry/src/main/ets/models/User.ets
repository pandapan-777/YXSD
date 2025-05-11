//登录接口请求参数类型
export interface AccountForModel {
  account: string
  password: string
}

//用户信息接口返回的类型
export interface UserInfoModel {
  //头像
  avatar: ResourceStr;

  //姓名
  name: string;

  //司机编号
  number: string;

  //手机号
  phone: string;
}