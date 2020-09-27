import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var rpx=MediaQuery.of(context).size.width/750;
    return Container(
      margin: EdgeInsets.all(5.0*rpx),
      color: Colors.white,
      width: 750*rpx,
      height: 150*rpx,
      child: Consumer<CartProvider>(
        builder: (context,child,childCategory){
          return  Row(
            children: <Widget>[
              selectAllBtn(context,rpx),
              allPriceArea(context,rpx),
              goButton(context,rpx)
            ],
          );
        },
      )
    );
  }

  //全选按钮
  Widget selectAllBtn(context,rpx){
    bool isAllCheck = Provider.of<CartProvider>(context,listen: false).isAllCheck;
    return Container(
      width: 180*rpx,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provider.of<CartProvider>(context,listen: false).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context,rpx){
    double allPrice = Provider.of<CartProvider>(context,listen: false).allPrice;
   
    return Container(
      //color: Colors.red,
      width: 380*rpx,
      //alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 100*rpx,
                child: Text(
                  '合计:',
                  style:TextStyle(
                    fontSize: 40*rpx
                  )
                ), 
              ),
              Container(
                 alignment: Alignment.centerLeft,
                width: 280*rpx,
                child: Text(
                  '￥${allPrice}',
                  style:TextStyle(
                    fontSize: 40*rpx,
                    color: Colors.cyan,
                  )
                ),
                
              )
             
              
            ],
          ),
          Container(
            width: 380*rpx,
            alignment: Alignment.centerLeft,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 25*rpx
              ),
            ),
          )
          
        ],
      ),
    );

  }

  //结算按钮
  Widget goButton(context,rpx){
    int allGoodsCount =  Provider.of<CartProvider>(context).allGoodsCounts;
    return Container(
      width: 170*rpx,
      padding: EdgeInsets.all(20*rpx),
      child:InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(20*rpx),
          alignment: Alignment.center,
          decoration: BoxDecoration(
             color: Color.fromRGBO(20, 185, 200, 1),
             borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ) ,
    );
    
  
  }

}