import 'package:flutter/material.dart';

import 'drawer_sample.dart';
import 'expandable_sample.dart';
import 'future_builder_sample.dart';
import 'grid_view_sample.dart';
import 'h_list_view_sample.dart';
import 'pull_load_more_sample.dart';
import 'tabbed_app_bar_sample.dart';
import 'v_list_view_sample.dart';

class TestApp extends StatelessWidget {
  TestApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //顶部导航
          buildButton(context, '顶部导航', TabbedAppBarSample()),
          //侧拉菜单
          buildButton(context, '侧拉菜单', DrawerSample()),
          //FutureBuilder
          buildButton(context, 'FutureBuilder', FutureBuilderSample()),
          //垂直滚动列表
          buildButton(context, '垂直滚动列表', VListViewSample()),
          //水平滚动列表
          buildButton(context, '水平滚动列表', HListViewSample()),
          //可展开的列表
          buildButton(context, "可展开的列表", ExpandableSample()),
          //网格布局
          buildButton(context, "网格布局", GridViewSample()),
          //下拉刷新与上拉加载更多
          buildButton(context, "下拉刷新与上拉加载更多", PullLoadMoreSample()),

        ],
      ),
    );
  }

  FlatButton buildButton(BuildContext context, String title, Widget widget) {
    return FlatButton(
      color: Colors.lightBlue,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
