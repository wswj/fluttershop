import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCount extends StatelessWidget {
  var item;
  var rpx;
  CartCount(this.item,this.rpx);



  @override
  Widget build(BuildContext context) {

    return Container(
      width: 165*rpx,
      margin: EdgeInsets.only(top:5.0*rpx),
      decoration: BoxDecoration(
        border:Border.all(width: 2*rpx , color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
      
    );
  }
  // 减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        Provider.of<CartProvider>(context,listen: false).addOrReduceAction(item,'reduce');
      },
      child: Container(
        width:45*rpx,
        height: 45*rpx,
        alignment: Alignment.center,
       
        decoration: BoxDecoration(
          color: item.count>1?Colors.white:Colors.black12,
          border:Border(
            right:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child:item.count>1? Text('-'):Text(' '),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provider.of<CartProvider>(context,listen: false).addOrReduceAction(item,'add');
      },
      child: Container(
        width: 45*rpx,
        height: 45*rpx,
        alignment: Alignment.center,
       
         decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            left:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: 60*rpx,
      height: 45*rpx,
      alignment: Alignment.center,
      color: Colors.white,
       child: Text('${item.count}'),
    );
  }

}