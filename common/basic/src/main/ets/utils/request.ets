//1.下载axios
//2.导入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { BASE_URL } from '../../../../Index';

//3.实例化对象
const service = axios.create({
  baseURL: BASE_URL,
  timeout: 10000
})

//4. 添加请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});


//5. 添加响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  if (response.status===200) {
    // 对响应数据做点什么
    return response.data.data
  }

}, (error: AxiosError) => {
  // 对响应错误做点什么
  return Promise.reject(error);
});

//6.创建自定义请求方式
export class Http {

  static  get<T>(url: string, params?: object) {
    return service.get<null, T>(url, { params })
  }

 static  post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

 static  put<T>(url: string, data: object) {
    return service.put<null, T>(url, data)
  }

 static  delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }

  //导出自定义Http

}