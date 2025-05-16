import { ImageListModel } from "basic";

export interface TaskDetailInfoModel {
  //实际到达时间
  actualArrivalTime: string;

  //实际发车时间
  actualDepartureTime: string;

  //创建时间
  created: string
  //提货凭证
  cargoPickUpPictureList: ImageListModel[];

  //提货图片
  cargoPictureList: ImageListModel[];

  //回单凭证
  certificatePictureList: ImageListModel[];

  //回单照片
  deliverPictureList: ImageListModel[];

  //司机id
  driverId: string;

  //车牌号
  licensePlace: string;

  //是否可提货
  enablePickUp: boolean;

  //司机姓名
  driverName: string;

  //目的市
  endAddress: string;

  //目的机构id
  endAgencyId: number;

  //目的机构详细地址
  endCity: string;

  //目的省份
  endProvince: string;
  exceptionList: ExceptionListModel[];

  //交付对接人
  finishHandover: string;

  //交付人电话
  finishHandoverPhone: string;

  //司机作业单id
  id: string;

  //计划到达时间
  planArrivalTime: string
  //计划发车时间
  planDepartureTime: string
  //车牌号码
  licensePlate: string
  //起始机构地址
  startAddress: string;

  //起始市
  startCity: string;

  //起始机构id
  startAgencyId: number
  //提货对接人
  startHandover: string
  //提货对接人
  startHandoverName: string;

  //提货对接人号码
  startHandoverPhone: string;

  //起始省份
  startProvince: string;

  //作业状态,1待提货，2在途，3改派，4已交付，5已作废
  status: number
  //运输任务id
  transportTaskId: string
}

export interface ExceptionListModel {
  exceptionDescribe: string
  exceptionImagesList: ImageListModel[];
  exceptionPlace: string
  exceptionTime: string;
  exceptionType: string
  handleResult: string;
}

export interface PickUpModel{
  //提货凭证拍照数组
  cargoPickUpPictureList:ImageListModel[];

  //提货照片数组
  cargoPictureList:ImageListModel[];
  //司机作业id
  id:string;


}



export interface deliverModel{
  //提货凭证拍照数组
  certificatePictureList:ImageListModel[];

  //提货照片数组
  deliverPictureList:ImageListModel[];
  //司机作业id
  id:string;


}
