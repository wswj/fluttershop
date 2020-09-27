

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{
  //初始化购物车
  String cartString="[]";
  List<CartInfoMode> cartList=[];
  double allPrice=0;
  int allGoodsCounts=0;
  bool isAllCheck=true;

  //购物车添加商品
  save(gameId,gameName,count,price,images)async{
    //初始化sharedpreferences
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    cartString=sharedPreferences.getString("cartInfo");
    var temp=cartString==null ? [] : json.decode(cartString.toString());
    //cast方法 将temp转化为列表后将列表中的每个元素转化为map集合
    List<Map> tempList=(temp as List).cast<Map>();
    //判断购物车是否含有此商品id
    var isHave=false;
    int ival=0;//用于进行循环的索引使用
    allPrice=0;
    allGoodsCounts=0;
    tempList.forEach((item){
      //循化判断购物车是否含有该商品
      if(item["goodsId"]==gameId){
        tempList[ival]["count"]=item["count"]+1;
        cartList[ival].count++;
        isHave=true;
      }
      if(item["isCheck"]){
        //判断商品是否是选中的状态,如果是选中状态则加上总价以及商品数总和
        allPrice+=(cartList[ival].price*cartList[ival].count);
        allGoodsCounts+=cartList[ival].count;
      }
      ival++;
    });
    //如果没有,则添加
    if(!isHave){
      Map<String, dynamic> newGoods={
        'goodsId':gameId,
        'goodsName':gameName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true  //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(CartInfoMode.fromJson(newGoods));
      allPrice+=count*price;
      allGoodsCounts+=count;
    }
    cartString= json.encode(tempList).toString();

    sharedPreferences.setString('cartInfo', cartString);//进行持久化
    notifyListeners();

  }

  //删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cartList=[];
    allPrice =0 ;
    allGoodsCounts=0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     
     //把cartList进行初始化，防止数据混乱 
     cartList=[];
     //判断得到的字符串是否有值，如果不判断会报错
     if(cartString==null){
       cartList=[];
     }else{
       List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
       allPrice=0;
       allGoodsCounts=0;
       isAllCheck=true;
       tempList.forEach((item){
        
          if(item['isCheck']){
             allPrice+=(item['count']*item['price']);
             allGoodsCounts+=item['count'];
          }else{
            isAllCheck=false;
          }
         
          cartList.add(new CartInfoMode.fromJson(item));

       });

     }
      notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     //decode将json字符串转化为json对象
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
   
     int tempIndex =0;
     int delIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==goodsId){
          delIndex=tempIndex;
         }
         tempIndex++;
     });
      tempList.removeAt(delIndex);
      //encode将数组转化为json字符串
      cartString= json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString);//
      await getCartInfo();
  }

  //修改选中状态
  changeCheckState(CartInfoMode cartItem) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
     int tempIndex =0;
     int changeIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex;
         }
         tempIndex++;
     });
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[];
    for(var item in tempList ){
      var newItem = item;
      newItem['isCheck']=isCheck;
      newList.add(newItem);
    } 
   
     cartString= json.encode(newList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();

  }

   //增加减少数量的操作

  addOrReduceAction(var cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex =0;
    int changeIndex=0;
    tempList.forEach((item){
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex; 
         }
         tempIndex++;
     });
     if(todo=='add'){
       cartItem.count++;
     }else if(cartItem.count>1){
       cartItem.count--;
     }
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();
  }
  

}