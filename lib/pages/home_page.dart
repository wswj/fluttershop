import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  String homepageContent="正在获取数据";
  int page=1;
  List<Map> HotListGame=[];
  GlobalKey<RefreshFooterState> _footer=new GlobalKey<RefreshFooterState>();
  @override
  void initState() { 
     super.initState();
    print('初次加载');
    //_getHotGames();
     
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的游戏")),
      //添加滑动组件
      // body: SingleChildScrollView(
      //   //child: Text(homepageContent),
      //  child: Column(
      //    children: <Widget>[
          

      //    ],
      //  )
      // ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            print("获取的数据为"+snapshot.data.toString());
            //var data=json.decode(snapshot.data.toString());
            //print(object)
            //轮播数据
            List<Map> swiper=(snapshot.data["Swiper"]["data"] as List).cast();
            //分类数据
            List<Map> kindlist=(snapshot.data["kindList"]["data"] as List).cast();
            //推荐数据
            List<Map> recommandList=(snapshot.data["freegameList"]["data"] as List).cast();
            //种类1的数据
            List<Map> kind1=(snapshot.data["kind1"]["data"]["game"] as List).cast();
            //种类2的数据
            List<Map> kind2=(snapshot.data["kind2"]["data"]["game"] as List).cast();

            return EasyRefresh(
              
              refreshFooter: ClassicsFooter(   
                key: _footer,
                loadedText: "加载完成",
                bgColor: Colors.white,
                textColor:Colors.red,
                moreInfoColor: Colors.red,
                noMoreText: "",
                showMore:true,
                moreInfo:"加载中",
                loadReadyText:"上拉加载"
                //mo
              ),
              //这里使用listview而不是scrollersinglechildview是因为页面状态保持的原因
              child:ListView(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper),
                TopNavigator(navigatorList: kindlist),
                Advertisment(),
                Recommand(recommandList: recommandList),
                FloorTitle(picture_address: "lib/images/u=2471305402,2956909494&fm=26&gp=0.jpg"),
                FloorContent(floorGoodsList: kind1),
                FloorTitle(picture_address: "lib/images/u=3709535632,110621967&fm=26&gp=0.jpg"),
                FloorContent(floorGoodsList: kind2),
                _hotGames()
              ],
            
            ),
            loadMore: () async{
              print("开始加载更多");
              var fromData={"page":page};
              await request("kind1list",formdata:fromData).then((val){
                List<Map> newGamesList=(val['data']["game"] as List).cast();
                setState(() {
                  HotListGame.addAll(newGamesList);
                  if(page<=val["data"]['page']["pages"]){
                  page++;
                  }
                });
              });
            },
            );
            
          }else{
            return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  //火爆专区

  // void _getHotGames(){
    
  // }
  //标题
  Widget hotTitle=Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("热门游戏"),
  );
  //游戏
  Widget _wrapList(){
    if(HotListGame!=null){
      List<Widget> listWidget=HotListGame.map((val){
        return InkWell(
          onTap:(){
            Application.router.navigateTo(context, "/detail?id=${val['id']}");
          },
          child: Container(
            width:ScreenUtil().setWidth(ScreenUtil.screenWidth/2.0-10),
            alignment: Alignment.center,
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Image.network(serviceUrl+'/img'+val["img"][0],height: ScreenUtil().setHeight(260),fit:BoxFit.cover),
                Text(val["name"],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.red,
                  fontSize:ScreenUtil().setSp(26)
                ),),
                Row(
                  children: <Widget>[
                    Text("￥${val["price"]}"),
                    Text("￥${val["price"]}",
                      style: TextStyle(
                        color: Colors.black26,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ],
                )

              ],

            ),
          )
        );
      }).toList();

      return Wrap(
        spacing:2,
        children:listWidget
      );
    }else{
      return Text("还没有游戏");
    }
  }

Widget _hotGames(){
  return Container(
    child: Column(
      children: <Widget>[
        hotTitle,
      _wrapList()
      ],
    )
  );
}
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

//轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  const SwiperDiy({this.swiperDataList});
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10)
      // ),
      margin: EdgeInsets.all(5),
      height: ScreenUtil().setHeight(380),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            child: Image.network(serviceUrl+'/img'+swiperDataList[index]["img"][0],fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
        
      ),
    );
  }
}
//广告条
class Advertisment extends StatelessWidget {
  const Advertisment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: ScreenUtil().setWidth(ScreenUtil.screenWidth-20),
      height: ScreenUtil().setHeight(380),
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: _launchURL,
        child: ClipRRect(
          child:Image.asset("lib/images/u=1196588241,524230738&fm=26&gp=0.jpg",fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(10),
      )
    )
    );
  }
  void _launchURL() async{
    String url='tel:'+'13083275770';
    if(await canLaunch(url)){
      print(url);
      await launch(url);
    }else{
      throw "异常，url不能访问";
    }
  }
}

//顶部分类信息
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  
  const TopNavigator({Key key,this.navigatorList}) : super(key: key);
  

  Widget _gridviewItem(BuildContext context,item){
    
      return InkWell(
        onTap: (){
          print("点击了分类导航");
        },
        child: Column(
          children: <Widget>[
            Image.asset("lib/images/"+item["id"].toString()+".jpg",width: ScreenUtil().setWidth(95),),
            Text(item["name"],maxLines: 1,overflow: TextOverflow.ellipsis,)
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if(navigatorList.length>10){
    this.navigatorList.removeRange(10,this.navigatorList.length);
  }
    return Container(
     height: ScreenUtil().setHeight(370),
     padding: EdgeInsets.all(10),
     child: GridView.count(
       physics: NeverScrollableScrollPhysics(),
       crossAxisCount: 5,
       padding: EdgeInsets.all(5),
       children: navigatorList.map((item){
         return _gridviewItem(context, item);
       }).toList()
       )
     );
    
  }
}

//免费游戏

class Recommand extends StatelessWidget {
  final List recommandList;
  const Recommand({Key key,this.recommandList}) : super(key: key);

//标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding:  EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
          bottom:BorderSide(width: 0.5,color: Colors.black12)
          ) 
      ),
      child: Text("免费游戏"),
    );
  }

//商品单项
Widget _item(index){
  return InkWell(
    onTap: (){
      
    },
    child: Container(
      height: ScreenUtil().setHeight(230),
      //color: Colors.yellow,
      width: ScreenUtil().setWidth(350),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Column(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            
            child:Image.network(serviceUrl+'/img'+recommandList[index]['img'][0],fit: BoxFit.cover,height: ScreenUtil().setHeight(200),)
            ),
          Text(recommandList[index]['name'],overflow: TextOverflow.ellipsis, maxLines: 1),
          Row(
            children: <Widget>[
              Text("￥${recommandList[index]['price']}"),
              Text("￥${recommandList[index]['price']}",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.red
                    ),
                  ),
            ],
          )
          
        ],
      ),
    ),
  );
}

//横向列表方法
Widget _recommandList(){
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recommandList.length,
      itemBuilder: (context,index){
        return _item(index);
      },
    ),
    height: ScreenUtil().setHeight(320),
    //color: Colors.blue,
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommandList()
        ],
      )

    );
  }
}

//楼层标题

class FloorTitle extends StatelessWidget {

  final String picture_address;
  const FloorTitle({Key key,this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: EdgeInsets.all(10),
      
      child:ClipRRect( 
      borderRadius: BorderRadius.circular(10),
      
      child: Container(
      
        width: ScreenUtil().setWidth(ScreenUtil.screenWidth-10),
      color:Colors.red,
      //padding: EdgeInsets.all(8),
      child: Image.asset(picture_address,fit: BoxFit.fill,),
    ),
    )
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  const FloorContent({Key key,this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      
      padding: EdgeInsets.only(left: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
        children: <Widget>[
          _firstRow(),
          _otherGoods()
        ],
      ),
      )
    );
  }

  Widget _firstRow(){
    return Row(
      //mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        
        Container(
          height: ScreenUtil().setHeight(400),
          //color: Colors.red,
          //padding: EdgeInsets.all(10),
          child: _goodsItem(floorGoodsList[0]),
        ),
        
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2])
          ],
        )
      ],
    );
  }

  //其他商品
 Widget _otherGoods(){
   return Row(
     
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4])
      ],
   );
 }


  Widget _goodsItem(Map goods){
      return Container(
        //color: Colors.red,
        height: ScreenUtil().setHeight(200),
        padding: EdgeInsets.all(2),
        //margin: EdgeInsets.all(10),
        width: ScreenUtil().setWidth((ScreenUtil.screenWidth/2)-20),
        child: InkWell(
          onTap: (){
            
          },
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(serviceUrl+"/img"+goods["img"][0],fit: BoxFit.fill,),
          )
          
        ),
      );
  }
}

// //火爆专区数据
// class _HotGoods extends StatefulWidget {
//   _HotGoods({Key key}) : super(key: key);

//   @override
//   __HotGoodsState createState() => __HotGoodsState();
// }

// class __HotGoodsState extends State<_HotGoods> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     request('kind1list',formdata: 1).then((val){
//       print(val);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Text("火爆专区"),
//     );
//   }
// }

 