//import 'package:flutter/cupertino.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/DeviceProvider.dart';
import 'package:flutter_shop/provider/cart_provider.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provider/provider.dart';

import 'cart_page/cart_bottom.dart';
import 'cart_page/cart_item.dart';

// // class CartPage extends StatelessWidget {
// //   const CartPage({Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Text("购物车"),
// //     );
// //   }
// // }
// class CartPage extends StatelessWidget {
//   const CartPage({Key key}) : super(key: key);
//   Future _getDevice(BuildContext context) async{
//     await Provider.of<DeviceProvider>(context,listen: false).getDevice();
//     return "加载完成";
//   }
//   @override
//   Widget build(BuildContext context) {
//     _getDevice(context);
//     return Scaffold(
//       body: FutureBuilder(
//         future: _getDevice(context),
//         builder: (context,snapshot){
//         if(snapshot.hasData){
//           return Center(
//         child: Column(
//           children: <Widget>[
//             //Number(),
//             //MyButton(),
//             DeviceInfos(Provider.of<DeviceProvider>(context,listen: false).deviceMap)
//             // FutureBuilder(
//             //   future: deviceInfo(),
//             //   builder: (context, snapshot) {
//             //     if(snapshot.connectionState==ConnectionState.done){
//             //       print("返回的数据为${snapshot.data.model}");
//             //     }
                
//             //     //AndroidDeviceInfo androidDeviceInfo=snapshot as AndroidDeviceInfo;

              
//             //       return Card(
//             //         child: ListView(
                      
//             //         )
//             //       );

                
//             //   })
//           ],
          
//         )
//       );
//         }else{
//           return Text("加载中");
//         }
//       }
//     )
//     );
//   }

   
// }
// class Number extends StatelessWidget {
//   const Number({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<Counter>(context);
//     return Container(
//       margin: EdgeInsets.only(top: 200),
//       child: Text("${counter.value}"),
//     );
//   }
// }
// class MyButton extends StatelessWidget {
//   const MyButton({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: RaisedButton(onPressed: (){
//         Provider.of<Counter>(context, listen: false).increment();
//       },
//       child:Text("递增")),
//     );
//   }
// }

// class DeviceInfos extends StatelessWidget {
//   const DeviceInfos(this.map,{Key key}) : super(key: key);
//   final Map<String,String> map;
//   //deviceInfo();
 
//   @override
//   Widget build(BuildContext context) {
//     //不能使用如下方法来初始化数据，而应该使用initstate来初始化数据
//     //deviceInfo();
    
//     return Container(
//       height: ScreenUtil().setHeight(1000),
//       child: Card(
//         margin: EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             ListTile(
//               title:Text("设备名称"),
//               subtitle:Text(map["deviceName"])
//             ),
//             ListTile(
//               title:Text("主板"),
//               subtitle:Text(map["board"])
//             ),
//             ListTile(
//               title:Text("系统启动程序版本号"),
//               subtitle:Text(map["bootloader"])
//             ),
//             ListTile(
//               title:Text("系统定制商"),
//               subtitle:Text(map["brand"])
//             ),
//             ListTile(
//               title:Text("设备参数"),
//               subtitle:Text(map["device"])
//             ),
//             ListTile(
//               title:Text("显示屏参数"),
//               subtitle:Text(map["display"])
//             ),
//             ListTile(
//               title:Text("唯一识别码"),
//               subtitle:Text(map["fingerprint"])
//             ),
//             ListTile(
//               title:Text("硬件名称"),
//               subtitle:Text(map["hardware"])
//             ),
//             ListTile(
//               title:Text("设备名称"),
//               subtitle:Text(map["host"])
//             ),
//              ListTile(
//               title:Text("修订版本列表"),
//               subtitle:Text(map["id"])
//             ),
//              ListTile(
//               title:Text("硬件制造商"),
//               subtitle:Text(map["manufacturer"])
//             ),
//              ListTile(
//               title:Text("整个产品的名称"),
//               subtitle:Text(map["product"])
//             ),
//           ],
//         )
//       ),
//     );
//   }
// }
class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future:_getCartInfo(context),
        builder: (context,snapshot){
          List cartList=Provider.of<CartProvider>(context).cartList;
          if(snapshot.hasData && cartList!=null){
              return Stack(
                children: <Widget>[
                  Consumer<CartProvider>(
                   
                    builder: (context,child,childCategory){
                       cartList= Provider.of<CartProvider>(context).cartList;
                      print(cartList);
                      return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context,index){
                          return CartItem(cartList[index]);
                        },
                      );
                    }
                  ), 
                ],
              );
        

          }else{
            return Text('正在加载');
          }
        },
      ),
      bottomNavigationBar: CartBottom(),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
     await Provider.of<CartProvider>(context).getCartInfo();
     return 'end';
  }

  
}