import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/home_dao.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/widget/grid_nav.dart';
import 'package:flutter_ctrip_app/widget/local_nav.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 80;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://pics0.baidu.com/feed/c8ea15ce36d3d539f604d802b6864555352ab039.jpeg?token=ede95b32d9d44ce29748bafa0132eb64&s=17E546A6D6B6CFCE5C8BFD2F03007049',
    'https://pics3.baidu.com/feed/3bf33a87e950352a180159e5df4257f7b3118b86.jpeg?token=b0c38ffc3d99e1eaa29ebbb25e32fc62&s=9B102CCD56779BDA543D26280300F05C',
    'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=3090773533,2679197754&fm=173&app=25&f=JPEG?w=600&h=425&s=1AA87423DB63EECC4EDCD1DE0000A0B1',
  ];

  final ScrollController _scrollController = ScrollController();
  double appBarAlpha = 0;

  String resultString = '';
  HomeModel homeModel;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll(_scrollController.offset);
    });
    loadData();
  }

  void _onScroll(double offset) {
    double tempAlpha = offset / APPBAR_SCROLL_OFFSET;
    if (tempAlpha > 1) {
      tempAlpha = 1.0;
    }
    if (tempAlpha < 0) {
      tempAlpha = 0.0;
    }
    setState(() {
      appBarAlpha = tempAlpha;
    });
  }

  loadData() async {
    try {
      var homeModel = await HomeDao.fetch();
      setState(() {
        this.homeModel = homeModel;
        resultString = json.encode(homeModel);
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          //去除ListView的padding，也可以使用MediaQuery.removePadding来实现
          padding: EdgeInsets.zero,
          //可以添加滚动监听，也可以使用NotificationListener实现，个人感觉controller更加方便
          controller: _scrollController,
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (context, index) {
                  return Image.network(
                    _imageUrls[index],
                    fit: BoxFit.fill,
                  );
                },
                pagination: SwiperPagination(),
              ),
            ),
            LocalNav(localNavList: this.homeModel == null ? [] : this.homeModel.localNavList),
            Container(
              height: 800,
              child: ListTile(
                title: Text(resultString),
              ),
            )
          ],
        ),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('首页'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
