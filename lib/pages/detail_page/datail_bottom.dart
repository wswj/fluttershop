import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/CurrentIndexProvider.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:flutter_shop/provider/detail_info.dart';
import 'package:provider/provider.dart';

class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    var gamesInfo = Provider.of<DetailsInfoProvider>(context,listen: false).gameDetail.data;

    var gameId = gamesInfo.id.toString();
    var gameName = gamesInfo.name;
    var count = 1;
    var price = gamesInfo.price;
    var images = gamesInfo.img[0];

    return Container(
      width: 750 * rpx,
      color: Colors.white,
      height: 100 * rpx,
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            InkWell(
                onTap: () {
                  Provider.of<CurrentIndexProvide>(context,listen: false).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                    width: 120 * rpx,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 60 * rpx,
                      color: Colors.red,
                    ))),
            Consumer<CartProvider>(
              builder: (context, child, val) {
                int goodsCount =
                    Provider.of<CartProvider>(context, listen: false)
                        .allGoodsCounts;
                return Positioned(
                    top: 0,
                    right: 10 * rpx,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          '${goodsCount}',
                          style: TextStyle(
                              color: Colors.white, fontSize: 22 * rpx),
                        )));
              },
            )
          ]),
          MaterialButton(
            elevation: 500*rpx,
            onPressed: () async {
              await Provider.of<CartProvider>(context,listen: false)
                  .save(gameId, gameName, count, price, images);
            },
            child: Container(
              width: 280*rpx,
              height: 95*rpx,
              alignment: Alignment.center,
              decoration:BoxDecoration(color:Colors.cyanAccent,borderRadius:BorderRadius.circular(50*rpx)),
              child:Text(
              "加入购物车",
              style: TextStyle(color: Colors.black, fontSize: 28 * rpx),
            )
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context,listen: false).remove();
            },
            child: Container(
              decoration:BoxDecoration(color:Colors.cyanAccent,borderRadius:BorderRadius.circular(10*rpx)),
              alignment: Alignment.center,
              width: 250 * rpx,
              height: 95 * rpx,
              //color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white, fontSize: 28 * rpx),
              ),
            ),
          )
        ],
      ),
    );
  }
}
