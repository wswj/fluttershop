import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/model/CartModel.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:provider/provider.dart';


class CartItem extends StatelessWidget {
  final CartInfoMode item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    var rpx=MediaQuery.of(context).size.width/750;
    print(item);
    return Container(
        margin: EdgeInsets.fromLTRB(5.0*rpx,2.0*rpx,5.0*rpx,2.0*rpx),
        padding: EdgeInsets.fromLTRB(5.0*rpx,10.0*rpx,5.0*rpx,10.0*rpx),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width:2*rpx,color:Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _cartCheckBt(context,item,rpx),
            _cartImage(item,rpx),
            _cartGoodsName(item,rpx),
            _cartPrice(context,item,rpx)
          ],
        ),
      );
  }
  //多选按钮
  Widget _cartCheckBt(context,item,rpx){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor:Colors.pink,
        onChanged: (bool val){
          item.isCheck=val;
          Provider.of<CartProvider>(context,listen: false).changeCheckState(item);
        },
      ),
    );
  }
  //商品图片 
  Widget _cartImage(item,rpx){
    
    return Container(
      width: 150*rpx,
      padding: EdgeInsets.all(5*rpx),
      decoration: BoxDecoration(
        border: Border.all(width: 2*rpx,color:Colors.black12)
      ),
      child: Image.network(serviceUrl + '/img'+item.images),
    );
  }
  //商品名称
  Widget _cartGoodsName(item,rpx){
    return Container(
      width: 300*rpx,
      padding: EdgeInsets.all(20*rpx),
      //alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item,rpx)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context,item,rpx){

    return Container(
        width:180*rpx ,
        alignment: Alignment.centerRight,
        
        child: Column(
          children: <Widget>[
            Text('￥${item.price}'),
            Container(
              child: InkWell(
                onTap: (){
                  Provider.of<CartProvider>(context,listen: false).deleteOneGoods(item.goodsId);
                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black26,
                  size: 60*rpx,
                ),
              ),
            )
          ],
        ),
      );
  }

}