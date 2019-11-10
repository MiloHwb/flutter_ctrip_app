import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/home_dao.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/widget/grid_nav.dart';
import 'package:flutter_ctrip_app/widget/local_nav.dart';
import 'package:flutter_ctrip_app/widget/sub_nav.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 120;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
      print(e);
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
    return this.homeModel != null
        ? Stack(
            children: <Widget>[
              ListView(
                //去除ListView的padding，也可以使用MediaQuery.removePadding来实现
                padding: EdgeInsets.zero,
                //可以添加滚动监听，也可以使用NotificationListener实现，个人感觉controller更加方便
                controller: _scrollController,
                children: <Widget>[
                  _buildBanner(context),
                  LocalNav(localNavList: this.homeModel.localNavList),
                  GridNav(gridNavModel: this.homeModel.gridNav),
                  SubNav(subNavList: this.homeModel.subNavList),
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
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  /// 构建Banner
  Container _buildBanner(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 16 * 9,
      child: Swiper(
        itemCount: this.homeModel.bannerList.length,
        autoplay: true,
        itemBuilder: (context, index) {
          var banner = this.homeModel.bannerList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebView(
                        url: banner.url,
                        statusBarColor: null,
                        title: null,
                        hideAppBar: false,
                        backForbid: true,
                      )));
            },
            child: Image.network(
              banner.icon,
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}
