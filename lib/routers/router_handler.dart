import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/detail_page.dart';

Handler detailsHandler=Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    String gameId=params["id"].first;
    print("gameid is ${gameId}");
    return DetailPage(gameId);
  }
);