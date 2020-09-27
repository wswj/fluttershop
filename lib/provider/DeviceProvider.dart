import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';

class DeviceProvider with ChangeNotifier{
  Map<String,String> deviceMap={};
  getDevice() async{
    DeviceInfoPlugin deviceInfo=DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo=await deviceInfo.androidInfo;
    print("设备名称为==================${androidDeviceInfo.model}");
    deviceMap["deviceName"]=androidDeviceInfo.model;
    print("${deviceMap["deviceName"]}");
    print("赋值结束=================================");
    //deviceMap["version"]=androidDeviceInfo.version;
    deviceMap["board"]=androidDeviceInfo.board;
    deviceMap["bootloader"]=androidDeviceInfo.bootloader;
    //生产厂家
    deviceMap["brand"]=androidDeviceInfo.brand;
    //工业设计名称
    deviceMap["device"]=androidDeviceInfo.device;
    //设备版本号
    deviceMap["display"]=androidDeviceInfo.display;

    deviceMap["fingerprint"]=androidDeviceInfo.fingerprint;
    //处理器
    deviceMap["hardware"]=androidDeviceInfo.hardware;

    deviceMap["host"]=androidDeviceInfo.host;
    
    deviceMap["id"]=androidDeviceInfo.id;
    deviceMap["manufacturer"]=androidDeviceInfo.manufacturer;
    //deviceMap["model"]=androidDeviceInfo.model;
    deviceMap["product"]=androidDeviceInfo.product;
    notifyListeners();
  }

}