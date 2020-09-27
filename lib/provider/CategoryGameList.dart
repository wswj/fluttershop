import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/model/CategoryGameList.dart';

class ChangeCategoryGameList with ChangeNotifier{
  List<Game> childList=[];
  getCategoryGameList(List<Game> list){
    childList=list;
    notifyListeners();
  }
  getMoreGame(List<Game> list){
    childList.addAll(list);
    notifyListeners();
  }
}