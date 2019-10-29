import 'package:flutter/material.dart';

import 'drawer_sample.dart';
import 'tabbed_app_bar_sample.dart';

class TestApp extends StatelessWidget {
  TestApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //顶部导航
          FlatButton(
            color: Colors.lightBlue,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TabbedAppBarSample();
              }));
            },
            child: Text(
              '顶部导航',
              style: TextStyle(color: Colors.white),
            ),
          ),
          //底部导航
          FlatButton(
            color: Colors.lightBlue,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DrawerSample();
              }));
            },
            child: Text(
              '侧拉菜单',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
