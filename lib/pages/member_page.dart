//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provider/provider.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("购物车"),
//     );
//   }
// }
class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            //Number(),
            MyButton(),
            ListView(
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              children:<Widget>[
                Container(child:Text("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")),
                Container(child:Text("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee")),
                Container(child:Text("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeggggggggggggggggggggggggggggggggggggggggggggggggggggggggeeeeeeeeeeeeeeeeeee")),
                Container(child:Text("顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶eeeeeeeeeeeeeeeeeeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffff")),
              ]
            )
          ],
          
        )
      ),
    );
  }
}
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
class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: (){
        Provider.of<Counter>(context, listen: false).increment();
      },
      child:Text("递增")),
    );
  }
}