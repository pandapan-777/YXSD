import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AdvertModel, defaultAd, UserSettingClass } from 'basic';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    //进入应用时，调用后台接口，获取广告配置
    const ad = await new Promise<AdvertModel>((resolve) => {
      setInterval(() => {
        resolve(defaultAd)
      }, 500)
    })
    //将广告配置存储到本地
    const setting = new UserSettingClass(this.context)
    setting.setUserAd(ad)

    //通过广告配置来决定是否显示广告
    if (ad.ShowAd) {
      //创建子窗口
      const win = await windowStage.createSubWindow("ad_window")

      //显示子窗口
      await win.showWindow()

      //加载广告页
      win.setUIContent("pages/Start/Start")
    }

    //获取token
    const token = setting.getUserToken()
    let path: string = ""
    if (token) {
      path = "pages/Index"
    } else {
      path = "pages/Login/Login"
    }


    windowStage.loadContent(path, (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}