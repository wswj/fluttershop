import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/CategoryGameList.dart';

class ChildCategory with ChangeNotifier{
  List childList=[];
  int childCategoryIndex=0;
  int page=1;
  String noMoreText;
  int categoryId=0;
  List<Game> gameList=[];
  int totalPage=0;

  //子类别列表
  getChildCategor(List list,int bigCategoryId){
    page=1;
    noMoreText='';
    categoryId=bigCategoryId;
    childList=list;
    list.map((i)=>print("获得的子类名称为==================${i.name}"));
    notifyListeners();
  }
  //子类索引
  changeChildCategoryIndex(int childIndex){
    childCategoryIndex=childIndex;
    notifyListeners();
  }
  //增加页数
  addPage(){
    page++;
    notifyListeners();
  }
  //改变页数
  editPage(){
    page=1;
    notifyListeners();
  }
  //获取更多数据
  getMoreGame(List<Game> list){
    gameList.addAll(list);
    notifyListeners();
  }
  //没有数据时的返回信息
  changeNoMoreText(String text){
    noMoreText=text;
  }
  //总页数
  changePage(int tpage){
    totalPage=tpage;
    notifyListeners();
  }
}