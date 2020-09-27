import 'package:flutter/material.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/provider/detail_info.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class DetailTopArea extends StatelessWidget {
  const DetailTopArea({Key key, this.pctx}) : super(key: key);
  final BuildContext pctx;
  @override
  Widget build(BuildContext context) {
     DetailsInfoProvider detailsInfoProvider =
         Provider.of<DetailsInfoProvider>(pctx);
         var gameDetail=detailsInfoProvider.gameDetail;
         if(gameDetail!=null){
            return Container(
      //width: 200,
      child: Column(
        children:<Widget>[
          _getSwiper(pctx,gameDetail.data.img),
         Container(
           child:Row(
             children:<Widget>[
               _gameIcon(pctx,gameDetail.data.img[0]),
               _gameInfo(pctx, gameDetail.data),
               _gamePrice(pctx,gameDetail.data.price)
             ]
           )
         )
        ]
      ),
    );
         }else{
           return CircularProgressIndicator();
         }
    
  }
}



//商品图片轮播图
Widget _getSwiper(context,imgList){
  double rpx = MediaQuery.of(context).size.width / 750;
    List<String> gameImgList = imgList.sublist(1);
    return Container(
      //color: Colors.red,
      width: 740 * rpx,
      height: 400 * rpx,
      margin: EdgeInsets.all(10*rpx),
      //decoration: BoxDecoration(ali),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Image.network(serviceUrl + '/img' + gameImgList[index],
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10*rpx),
          );
        },
        itemCount: gameImgList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
}

//游戏信息
Widget _gameInfo(context,game){
  double rpx = MediaQuery.of(context).size.width / 750;
  return Container(
    width: 375*rpx,
    height: 200*rpx,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _gameName(context,game.name),
      _gameDeployer(context,game.creater),
      _gameTags(context, game.tags)
      ],

    ),
  );
}
//商品图标
Widget _gameIcon(context,imgIcon){
  double rpx = MediaQuery.of(context).size.width / 750;
  return Container(
    margin: EdgeInsets.only(left:10*rpx,right:10*rpx),
    width: 200*rpx,
    height:200*rpx,
    child:ClipRRect(
            child: Image.network(serviceUrl + '/img' + imgIcon,
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10*rpx),
          )
  );
}
//游戏名称
Widget _gameName(context,name){
  double rpx = MediaQuery.of(context).size.width / 750;
  return Container(
    child:Text(
      "${name}",
      style:TextStyle(
        fontWeight:FontWeight.w600,
        fontSize:45*rpx
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    )
  );
}

//游戏开发商
Widget _gameDeployer(context,name){
  double rpx = MediaQuery.of(context).size.width / 750;
  return Container(

    child:Text(
      "开发商：${name}",
      style:TextStyle(
        fontWeight:FontWeight.w300,
        fontSize:20*rpx
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    )
  );
}

//游戏标签
Widget _gameTags(context,tags){
  double rpx = MediaQuery.of(context).size.width / 750;
  List tag=tags;
  if(tag.length>3){
    tag=tag.sublist(0,3);
  }
  return Container(
    //margin: EdgeInsets.all(5*rpx),
    //width: 50*rpx,
    height: 50*rpx,
    
    child:ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: tag.length,
      itemBuilder: (BuildContext context, int index) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5*rpx),
          color:Colors.cyan,),
        padding: EdgeInsets.all(5*rpx),
        margin: EdgeInsets.all(5*rpx),
        
        child:Text("${tag[index].name}",style: TextStyle(fontSize:20*rpx),)
      );
     },
    ),  
  );
}

Widget _gamePrice(context,price){
  double rpx = MediaQuery.of(context).size.width / 750;
  return Container(
    width: 140*rpx,
    height: 140*rpx,
    decoration: BoxDecoration(
      borderRadius:BorderRadius.circular(20*rpx),
      color: Colors.cyan
    ),
    child: Center(
      child:Text(price==0.0?"免费":"${price}",style: TextStyle(color:Colors.white,fontSize: 50*rpx,fontWeight: FontWeight.w700))
    ),
  );
}