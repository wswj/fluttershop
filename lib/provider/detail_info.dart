import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvider extends State<StatefulWidget> with ChangeNotifier,TickerProviderStateMixin{
  GameDetail gameDetail;
  TabController controller;
  //从后台获取商品信息
  getGameInfo(String id) async{
    await requestV2("getGameById",id).then((val){
      var responseData=val;
      gameDetail=GameDetail.fromJson(responseData);
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  
}