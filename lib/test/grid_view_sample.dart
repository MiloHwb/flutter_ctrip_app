import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/1 20:52
 * @ 描述         
 */
const CITY_NAMES = ['北京', '上海', '深圳', '广州', '杭州', '苏州', '成都', '武汉', '南京', '郑州', '长沙', '重庆', '南京'];

class GridViewSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('网格布局'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return CITY_NAMES
        .map((city) => Container(
              height: 100,
              decoration: BoxDecoration(color: Colors.teal),
              child: Center(
                child: Text(
                  city,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ))
        .toList();
  }
}
