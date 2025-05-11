//1.下载axios
//2.导入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { BASE_URL, UserSettingClass } from '../../../../Index';
import { promptAction, router } from '@kit.ArkUI';

//3.实例化对象
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 10000
})

//4. 添加请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {

  const setting = new UserSettingClass(getContext())

  //获取token
  const token = setting.getUserToken()
  //如果token存在
  if (token) {
    //将token通过请求头发送给后台
    config.headers.Authorization = token
  }

  // 对请求数据做点什么
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});


//5. 添加响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  if (response.status === 200) {
    // 对响应数据做点什么
    return response.data.data
  }

}, (error: AxiosError) => {
  //token过期
  if (error.response?.status === 401) {
    promptAction.showToast({
      message: "登录超时"
    })
    //删除原来的token
    const setting = new UserSettingClass(getContext())
    setting.setUserToken("")
    //重新登录
    router.replaceUrl({
      url: "pages/Login/Login"
    })
  }
  // 对响应错误做点什么
  return Promise.reject(error);
});

//6.创建自定义请求方式
export class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data: object) {
    return service.put<null, T>(url, data)
  }

  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }

  //导出自定义Http

}