import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/10/31 22:33
 * @ 描述         
 */
const CITY_NAMES = ['北京', '上海', '深圳', '广州', '杭州', '苏州', '成都', '武汉', '南京', '郑州', '长沙', '重庆', '南京'];

class HListViewSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: 200,//这边设置高度才会生效
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      width: 160,
//      height: 200,//在这里设置高度无效
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.teal),
      child: Text(
        city,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
