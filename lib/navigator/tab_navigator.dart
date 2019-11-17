import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/page/home_page.dart';
import 'package:flutter_ctrip_app/page/my_page.dart';
import 'package:flutter_ctrip_app/page/search_page.dart';
import 'package:flutter_ctrip_app/page/travel_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {
  PageController _controller;
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    //显示第一个tab
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(
            hideLeft: true,
          ),
          TravelPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(), //不允许用户滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          //首页按钮
          buildBottomNavigationBarItem(Icons.home, 0, '首页'),
          //搜索按钮
          buildBottomNavigationBarItem(Icons.search, 1, '搜索'),
          //旅拍
          buildBottomNavigationBarItem(Icons.camera, 2, '旅拍'),
          //我的
          buildBottomNavigationBarItem(Icons.account_box, 3, '我的'),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData iconData, int index, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: _defaultColor,
      ),
      activeIcon: Icon(
        iconData,
        color: _activeColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: _currentIndex == index ? _activeColor : _defaultColor),
      ),
    );
  }
}
