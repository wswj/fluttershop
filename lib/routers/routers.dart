import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routes{
  static String root="/";
  static String detailsPage="/detail";
  static void configureRouters(Router router){
    //没有找到对应的路由时提示错误
    router.notFoundHandler=new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print("ERROR=================Router Not Found");
      }
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}