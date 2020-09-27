import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/CurrentIndexProvider.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("会员中心")),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  //int currentindex=0;
  //var currentpage;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return Consumer<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentindex =
            Provider.of<CurrentIndexProvide>(context, listen: false)
                .currentIndex;
        return Container(
          child: Scaffold(
              backgroundColor: Colors.red,
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentindex,
                items: bottomTabs,
                onTap: (index) {
                  Provider.of<CurrentIndexProvide>(context, listen: false)
                      .changeIndex(index);
                },
              ),
              body: IndexedStack(
                  index:
                      Provider.of<CurrentIndexProvide>(context, listen: false)
                          .currentIndex,
                  children: tabBodies)),
        );
      },
    );
  }
}
