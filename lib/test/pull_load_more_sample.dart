import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/1 21:05
 * @ 描述         
 */

List<String> cityNames = [
  '北京',
  '上海',
  '深圳',
  '广州',
  '杭州',
  '苏州',
  '成都',
  '武汉',
  '南京',
  '郑州',
  '长沙',
  '重庆',
  '南京'
];

class PullLoadMoreSample extends StatefulWidget {
  PullLoadMoreSample({Key key}) : super(key: key);

  @override
  _PullLoadMoreSampleState createState() => _PullLoadMoreSampleState();
}

class _PullLoadMoreSampleState extends State<PullLoadMoreSample> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadData();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('下拉刷新与上拉加载更多'),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            controller: _controller,
            children: _buildList(),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        cityNames = cityNames.reversed.toList();
      });
    });
    return null;
  }

  List<Widget> _buildList() {
    return cityNames
        .map((city) => Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 5),
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

  void _loadData() async {
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        List<String> list = List.from(cityNames);
        list.addAll(cityNames);
        cityNames = list;
      });
    });
  }
}
