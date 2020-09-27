import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/provider/detail_info.dart';
import 'package:provider/provider.dart';

class DetailExplan extends StatelessWidget {
  const DetailExplan({Key key,this.ptx,this.controller}) : super(key: key);
  final BuildContext ptx;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    DetailsInfoProvider detailsInfoProvider =
         Provider.of<DetailsInfoProvider>(ptx);
         var gameDetail=detailsInfoProvider.gameDetail;
    double rpx = MediaQuery.of(ptx).size.width / 750;
    return DefaultTabController(length: 2, child: Column(
      //shrinkWrap: true,
      mainAxisSize:MainAxisSize.min,
      children:<Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal:100*rpx),
      width: 740*rpx,
      height: 70*rpx,
      margin: EdgeInsets.all(10*rpx),
      //color: Colors.redAccent,
      child: TabBar(
        indicatorPadding: EdgeInsets.symmetric(horizontal: 150*rpx),
        labelStyle: TextStyle(fontSize:35*rpx,),
        unselectedLabelStyle: TextStyle(fontSize:30*rpx,),
        labelPadding: EdgeInsets.symmetric(horizontal: 20*rpx),
        labelColor: Colors.cyan[300],
        unselectedLabelColor: Colors.grey[300],
        tabs: <Widget>[
        Tab(child:Text("详情")),
        Tab(child:Text("评论"))

      ]),
    ),
    Container(
      //width: 740*rpx,
      margin: EdgeInsets.all(10*rpx),
      color: Colors.blue,
      height: 1000*rpx,
      child:TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        children:<Widget>[
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children:<Widget>[
            _gameDesc(ptx,gameDetail.data.desc),
            _getGamePic(ptx, gameDetail.data.img),
            _getGameCfg(ptx,gameDetail.data.systemcfg)
          ])
         ,
          Text("1")
        ]
      )
    )
    
    ]
    )
      
      
    );
  }
}

//游戏详情
Widget _gameDesc(context,desc){
  double rpx=MediaQuery.of(context).size.width/750;
  return Container(
    margin: EdgeInsets.only(left:10*rpx),
    child:ListTile(
      contentPadding: EdgeInsets.only(left:0),
      title:Container(
        margin:EdgeInsets.only(bottom:10*rpx),
        child:Text("简介",style: TextStyle(fontWeight:FontWeight.w500,fontSize:40*rpx),)),
      subtitle:Text("${desc}",style: TextStyle(color:Colors.black,height: 1.5,fontSize:30*rpx ),)
    )
  );
}


//游戏图片
Widget _getGamePic(context,pics){
  List pic=pics.sublist(1);
  double rpx=MediaQuery.of(context).size.width/750;
  return Container(
    //color: Colors.redAccent,
    alignment: Alignment.topLeft,
    margin: EdgeInsets.all(10*rpx),
    height: 450*rpx,
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Container(
          height: 50*rpx,
          margin: EdgeInsets.only(left:10*rpx),
          child: Text("游戏截图",style: TextStyle(fontWeight:FontWeight.w500,fontSize:40*rpx)),
        ),
        Container(
          height:380*rpx,
          child:ListView.builder(
      scrollDirection:Axis.horizontal,
      itemCount: pic.length,
      itemBuilder: (context,index){
        return Container(
          width: 250*rpx,
          //height: 100*rpx,
          margin: EdgeInsets.only(right:10*rpx),
          child: ClipRRect(
            borderRadius:BorderRadius.circular(20*rpx),
            child:Image.network(serviceUrl + '/img' + pic[index],
                fit: BoxFit.fill,)),
        );
      },
  )
        )
      ]
    ));
}

//游戏配置信息
Widget _getGameCfg(context,cfg){
  double rpx=MediaQuery.of(context).size.width/750;
  return Container(
    //height: 100*rpx,
    child:Text(
      "${cfg}"
    )
  );
}