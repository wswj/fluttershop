import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

//获取首页内容
Future getHomePageContent() async{
  Map homeContent=new Map();
  try{
    print("开始获取首页数据");
    Response response;
    Dio dio =new Dio();
    dio.options.contentType= "application/x-www-form-urlencoded";
    //var formdate={'lon':'115.02932','lat':'35.76189'};
    //获取首页轮播图数据
    response=await dio.post(serviceUrl+servicePath['swiperContent']);
    if(response.statusCode==200){
      print("获得的数据为"+response.data.toString()) ;
      //return response.data;
      homeContent.addAll({"Swiper":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得轮播图数据");
    }

    //获得分类信息
    response=await dio.post(serviceUrl+servicePath['kindlist']);
    if(response.statusCode==200){
      print("获得的数据为"+response.data.toString()) ;
      //return response.data;
      homeContent.addAll({"kindList":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得分类数据");
    }

    //获得免费游戏信息
    response=await dio.post(serviceUrl+servicePath['freegame']);
    if(response.statusCode==200){
      print("获得的数据为"+response.data.toString()) ;
      //return response.data;
      homeContent.addAll({"freegameList":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得免费游戏数据");
    }

    //获得游戏分类信息

    response=await dio.post(serviceUrl+servicePath['kind1']);
    if(response.statusCode==200){
      print("获得的分类数据为"+response.data.toString()) ;
      //return response.data;
      homeContent.addAll({"kind1":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得种类1的数据");
    }

    response=await dio.post(serviceUrl+servicePath['kind2']);
    if(response.statusCode==200){
      print("获得的分类数据为"+response.data.toString()) ;
      //return response.data;
      homeContent.addAll({"kind2":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得种类2的数据");
    }
    return homeContent;

  }catch(e){
    return print("ERROR=======>${e}");
  }
}
Future request(url,{formdata}) async{
  print("开始获取数据");
    Response response;
    Dio dio =new Dio();
    dio.options.contentType= "application/x-www-form-urlencoded";
    //如果提交数据为空
    if(formdata==null){
      response=await dio.post(serviceUrl+servicePath[url]);
    }else{
      response=await dio.post(serviceUrl+servicePath[url],data:formdata);
    }

    if(response.statusCode==200){
      print("获得的数据为"+response.data.toString()) ;
      //返回接收到的数据
      return response.data;
      //homeContent.addAll({"Swiper":response.data});
      
    }else{
      throw Exception("后端接口错误，无法获得轮播图数据");
    }
}

Future requestV2(url,data) async{
  print("开始获取数据");
    Response response;
    Dio dio =new Dio();
    dio.options.contentType= "application/x-www-form-urlencoded";
    url=serviceUrl+servicePath[url]+data;
    //print("拼接的url为============================================================"+url);
    //如果提交数据为空
    response=await dio.post(url);
    if(response.statusCode==200){
      print("获得的数据为"+response.data.toString()) ;
      //返回接收到的数据
      return response.data;
      //homeContent.addAll({"Swiper":response.data});
      
    }else{
      throw Exception("后端接口错误");
    }
}



