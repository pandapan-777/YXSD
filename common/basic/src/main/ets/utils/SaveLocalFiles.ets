import { fileIo } from '@kit.CoreFileKit'
import { ImageListModel } from '../models'
import { request } from '@kit.BasicServicesKit'
import { uploadFile } from '../api/upload'

export const SaveLocalFiles = async (dataSource: ImageListModel[]) => {
  //1.选择文件路径
  const saveDir = getContext().cacheDir

  // 创建用于上传的文件参数数组
  const fileParams: request.File[] = []


  dataSource.forEach((item: ImageListModel) => {

    //2.图片的名称
    const ImageName = Date.now() + ".jpg"

    //3.读取相册文件
    const file = fileIo.openSync(item.url, fileIo.OpenMode.READ_ONLY)
    //4.将选择图片拷贝到沙箱目录中
    fileIo.copyFileSync(file.fd, saveDir + "/" + ImageName)
    //5关闭文件数据的读取
    fileIo.closeSync(file.fd)

    //将上传的每一个文件添加到fileParams中
    fileParams.push({
      filename: ImageName,
      name: "file",
      type: "jpg",
      uri: `internal://cache/${ImageName}`
    })


  })

  return await uploadFile(getContext(), fileParams)


}