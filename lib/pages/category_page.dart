import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/CategoryGameList.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/provider/CategoryGameList.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _test();
    return Scaffold(
        appBar: AppBar(
          title: Text("商品分类"),
        ),
        body: Container(
            child: Row(children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[RightCategoryNav(), CategoryGameList()],
          )
        ])));
  }

  _test() async {
    await request("getKinds").then((val) {
      //print(val.toString());
      KindModel kindList = KindModel.fromJson(val["data"]);
      kindList.data.forEach((item) => print(item.name));
    });
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getKind();
    _getGamesList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(ScreenUtil.screenWidth * 0.3),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkwell(index);
        },
      ),
    );
  }

  void _getKind() async {
    await request("getKinds").then((val) {
      KindModel kindModel = KindModel.fromJson(val["data"]);
      setState(() {
        list = kindModel.data;
      });
      Provider.of<ChildCategory>(context, listen: false)
          .getChildCategor(list[0].childList, list[0].id);
    });
  }

  _getGamesList({int kindId}) async {
    var data = {
      //"kind":1,
      "page": 1
    };

    await request(kindId == null ? "kind11" : "kind1" + "${kindId}",
            formdata: data)
        .then((val) {
      print("获取的种类数据为" + val.toString());
      CategoryGamesList categoryGameList = CategoryGamesList.fromJson(val);
      // setState(() {
      //   list=categoryGameList.data.game;
      // });
      //print("huoqv==========="+categoryGameList.data.game[0].name);
      Provider.of<ChangeCategoryGameList>(context, listen: false)
          .getCategoryGameList(categoryGameList.data.game);
      Provider.of<ChildCategory>(context, listen: false)
          .changePage(categoryGameList.data.page.pages);
    });
  }

  Widget _leftInkwell(int index) {
    bool isClick = false;
    isClick = (listIndex == index) ? true : false;
    return InkWell(
        onTap: () {
          setState(() {
            listIndex = index;
          });
          print("index+1的值为============${index}");
          _getGamesList(kindId: index + 1);
          Provider.of<ChildCategory>(context, listen: false)
              .changeChildCategoryIndex(0);
          Provider.of<ChildCategory>(context, listen: false)
              .getChildCategor(list[index].childList, list[index].id);
          Provider.of<ChildCategory>(context, listen: false).editPage();

          //Provider.of<ChangeCategoryGameList>(context, listen: false).getCategoryGameList();
        },
        child: Container(
          height: ScreenUtil().setHeight(100),
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: isClick ? Colors.red : Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: Text(list[index].name),
          alignment: Alignment.centerLeft,
        ));
  }
}

class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List list;
  int rightList = 0;
  @override
  Widget build(BuildContext context) {
    final childCategory = Provider.of<ChildCategory>(context);
    list = childCategory.childList;
    return Container(
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(ScreenUtil.screenWidth * 0.7),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _rightInkWell(index);
          }),
    );
  }

  Widget _rightInkWell(int index) {
    bool rightIsClick = false;
    rightIsClick =
        (Provider.of<ChildCategory>(context).childCategoryIndex == index)
            ? true
            : false;
    return InkWell(
        onTap: () {
          Provider.of<ChildCategory>(context, listen: false)
              .changeChildCategoryIndex(index);
          print("rightList为" + rightList.toString());
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              list[index].name,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: rightIsClick ? Colors.red : Colors.black),
            )));
  }
}

//商品列表
class CategoryGameList extends StatefulWidget {
  CategoryGameList({Key key}) : super(key: key);

  @override
  _CategoryGameListState createState() => _CategoryGameListState();
}

class _CategoryGameListState extends State<CategoryGameList> {
  List list = [];
  var scorllController = ScrollController();
  //bool _loadMore=true;
  GlobalKey<RefreshFooterState> _footer = new GlobalKey<RefreshFooterState>();
  @override
  Widget build(BuildContext context) {
    final gameList = Provider.of<ChangeCategoryGameList>(context);
    list = gameList.childList;
    if (list != null) {
      return Consumer<ChangeCategoryGameList>(builder: (context, category, _) {
        try {
          if (Provider.of<ChildCategory>(context, listen: false).page == 1) {
            //列表位置回弹到底部
            scorllController.jumpTo(0);
          }
        } catch (e) {
          print("第一次进入页面");
        }
        return Expanded(
            child: Container(
          width: ScreenUtil().setWidth(ScreenUtil.screenWidth * 0.7),
          //height: ScreenUtil().setHeight(1000),
          child: EasyRefresh(
            refreshFooter: ClassicsFooter(
                key: _footer,
                loadedText: "加载完成",
                bgColor: Colors.white,
                textColor: Colors.red,
                moreInfoColor: Colors.red,
                noMoreText: Provider.of<ChildCategory>(context, listen: false)
                    .noMoreText,
                showMore: true,
                moreInfo: "加载中",
                loadReadyText: "上拉加载"
                //mo
                ),
            //这里使用listview而不是scrollersinglechildview是因为页面状态保持的原因
            child: ListView.builder(
              controller: scorllController,
              itemBuilder: (context, index) {
                return _listWidget(index);
              },
              itemCount: list.length,
            ),
            loadMore: () async {
              print("开始加载更多");
              Provider.of<ChildCategory>(context, listen: false).addPage();
              var fromData = {
                "page": Provider.of<ChildCategory>(context, listen: false).page
              };
              print("参数完毕");
              if (Provider.of<ChildCategory>(context, listen: false)
                          .totalPage ==
                      0 ||
                  Provider.of<ChildCategory>(context, listen: false).page <=
                      Provider.of<ChildCategory>(context, listen: false)
                          .totalPage) {
                await request(
                        "kind1${Provider.of<ChildCategory>(context, listen: false).categoryId}",
                        formdata: fromData)
                    .then((val) {
                  print("========================" + val.toString());
                  List<Game> newGamesList = (val["data"]["game"] as List)
                      .map((i) => Game.fromJson(i))
                      .toList();
                  Provider.of<ChangeCategoryGameList>(context, listen: false)
                      .getMoreGame(newGamesList);
                  Provider.of<ChildCategory>(context, listen: false)
                      .changePage(val["data"]["page"]["pages"]);
                  if (Provider.of<ChildCategory>(context, listen: false).page ==
                      Provider.of<ChildCategory>(context, listen: false)
                          .totalPage) {
                    Provider.of<ChildCategory>(context, listen: false)
                        .changeNoMoreText("已经到底了");
                  }
                });
              } else {
                Fluttertoast.showToast(
                    msg: "已经到底",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
          ),
        ));
      });
    } else {
      return Container(
        alignment: Alignment.center,
        child: Text("暂时没有数据"),
      );
    }
  }

  //游戏封面图片
  Widget _gameImage(int index) {
    return Container(
        padding: EdgeInsets.only(left: 5),
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setSp(150),
        child: Image.network(serviceUrl + "/img" + list[index].img[0],
            fit: BoxFit.fill));
  }

  //游戏名称
  Widget _gameName(int index) {
    return Container(
      width: ScreenUtil().setWidth(300),
      child: Text(
        list[index].name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //游戏价格
  Widget _gamePrice(int index) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: <Widget>[
            Text(
              "价格：￥${list[index].price}",
              style: TextStyle(
                  color: Colors.red, fontSize: ScreenUtil().setSp(28)),
            ),
            Text("￥${list[index].price}",
                style: TextStyle(
                    color: Colors.black12,
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.lineThrough))
          ],
        ));
  }

  //listView子类
  Widget _listWidget(int index) {
    return InkWell(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Row(children: <Widget>[
              _gameImage(index),
              SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[_gameName(index), _gamePrice(index)],
              )
            ])));
  }
}
