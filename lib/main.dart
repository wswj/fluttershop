import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';//还有另一种风格
import 'package:flutter_shop/provider/CategoryGameList.dart';
import 'package:flutter_shop/provider/CurrentIndexProvider.dart';
import 'package:flutter_shop/provider/DeviceProvider.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:flutter_shop/provider/detail_info.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routers.dart';
import 'package:provider/provider.dart';
import 'pages/index_page.dart';
//import 'package:provide';
void main() {
  // var counter=Counter();
  // var providers=Provider(create: (BuildContext context) {},);
  
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router=Router();
    Routes.configureRouters(router);
    Application.router=router;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Counter()),
        ChangeNotifierProvider(create: (_)=>ChildCategory()),
        ChangeNotifierProvider(create: (_)=>ChangeCategoryGameList()),
        ChangeNotifierProvider(create: (_)=>DeviceProvider()),
        ChangeNotifierProvider(create: (_)=>DetailsInfoProvider()),
        ChangeNotifierProvider(create: (_)=>CurrentIndexProvide()),
        ChangeNotifierProvider(create: (_)=>CartProvider())
        ],
      child: Consumer<Counter>(
        builder: (context,counter,_){
          return Container(
            child: Container(
                child: MaterialApp(
                  onGenerateRoute: Application.router.generator,
                  title: "游戏商城",
                  //关闭右上角的deubg标签
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(primaryColor: Color.fromRGBO(20, 185, 200, 1)),
                  home: IndexPage(),
                ),
            ),
    );
        })
    );
  }
}