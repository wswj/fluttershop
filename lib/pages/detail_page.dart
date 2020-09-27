import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detail.dart';
import 'package:flutter_shop/pages/detail_page/datail_bottom.dart';
import 'package:flutter_shop/pages/detail_page/detail_explan.dart';
import 'package:flutter_shop/pages/detail_page/details_top_area.dart';
import 'package:flutter_shop/pages/test.dart' as test1;
import 'package:flutter_shop/provider/detail_info.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart' show AsyncMemoizer;

class DetailPage extends StatefulWidget {
  DetailPage(this.gameid, {Key key}) : super(key: key);
  final String gameid;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Future future;
  final AsyncMemoizer asyncMemoizer = AsyncMemoizer();
  ScrollController _controller;
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("商品详情"),
            leading: IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.done) {
              return Stack(
                children:<Widget>[
                  ListView(
                  controller: _controller,
                  shrinkWrap: true,
                  //physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    DetailTopArea(
                  pctx: context,
                ),
                DetailExplan(ptx: context,controller:_controller)
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailBottom())
                ], 
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: asyncMemoizer.runOnce(() async {
            return await getDetailInfo(widget.gameid);
          }),
        ));
  }

  Future getDetailInfo(gameid) async {
    await Provider.of<DetailsInfoProvider>(context).getGameInfo(gameid);
    //print(Provider.of<DetailsInfoProvider>(context).gameDetail.data.name+"=================================================");
    return "完成加载================================================";
  }
}

// Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
//    switch (snapshot.connectionState) {
//      case ConnectionState.none:
//        print('还没有开始网络请求');
//        return Text('还没有开始网络请求');
//      case ConnectionState.active:
//        print('active');
//        return Text('ConnectionState.active');
//      case ConnectionState.waiting:
//        print('waiting===========================================');
//        if(snapshot.connectionState==ConnectionState.waiting){
//          //Timer(Duration(milliseconds:300,(){}));
//          return Center(
//          child: CircularProgressIndicator(),
//        );

//        }
//        return Center(
//          child: CircularProgressIndicator(),
//        );

//      case ConnectionState.done:
//        print('done');
//        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//        return Container(
//               child: DetailTopArea(pctx: context,),
//             );
//      default:
//        return Text('还没有开始网络请求');
//    }
//  }
