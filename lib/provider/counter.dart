import 'package:flutter/cupertino.dart';

class Counter with ChangeNotifier{
  int value=0;
  increment(){
    value++;
    notifyListeners();
  }
}