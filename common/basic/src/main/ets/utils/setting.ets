import { preferences } from '@kit.ArkData';
import { AdvertModel } from '../models/advert';

//默认广告位
export const defaultAd: AdvertModel = {
  //广告时长
  AdTime: 5,
  //广告显示
  ShowAd: true,
  //广告图片
  ImageAd: $r("app.media.start")
}

export class UserSettingClass {
  //上下文
  context: Context

  //实例化
  constructor(context: Context) {
    //初始化上下文对象
    this.context = context;
  }


  //创建仓库
  getStore() {
    return preferences.getPreferencesSync(this.context, {
      name: "setting"
    })
  }

  //存储数据
  setUserAd(ad: AdvertModel) {
    //获取仓库
    const store = this.getStore()
    //给仓库中存储数据
    store.putSync("setting_ad", JSON.stringify(ad))
    //将输入写入磁盘中
    store.flush()
  }

  //获取数据
  getUserAd(): AdvertModel {
    //获取创建的仓库
    const store = this.getStore()
    //获取广告数据
    return JSON.parse(store.getSync("setting_ad", JSON.stringify(defaultAd)) as string)
  }
}