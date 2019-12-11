import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/home_dao.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/page/search_page.dart';
import 'package:flutter_ctrip_app/page/speak_page.dart';
import 'package:flutter_ctrip_app/widget/grid_nav.dart';
import 'package:flutter_ctrip_app/widget/loading_container.dart';
import 'package:flutter_ctrip_app/widget/local_nav.dart';
import 'package:flutter_ctrip_app/widget/sale_box_nav.dart';
import 'package:flutter_ctrip_app/widget/search_bar.dart';
import 'package:flutter_ctrip_app/widget/sub_nav.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

const APPBAR_SCROLL_OFFSET = 120;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

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

  HomeModel homeModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll(_scrollController.offset);
    });
    _handleRefresh();
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

  Future<Null> _handleRefresh() async {
    try {
      var homeModel = await HomeDao.fetch();
      setState(() {
        this.homeModel = homeModel;
        this.isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
//        this.isLoading = false;
      });
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        isLoading: this.isLoading,
        child: this.isLoading
            ? null
            : Stack(
                children: <Widget>[
                  RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: _buildListView(context),
                  ),
                  _buildTitle(),
                ],
              ));
  }

  ListView _buildListView(BuildContext context) {
    return ListView(
      //去除ListView的padding，也可以使用MediaQuery.removePadding来实现
      padding: EdgeInsets.zero,
      //可以添加滚动监听，也可以使用NotificationListener实现，个人感觉controller更加方便
      controller: _scrollController,
      children: <Widget>[
        _buildBanner(context),
        LocalNav(localNavList: this.homeModel.localNavList),
        GridNav(gridNavModel: this.homeModel.gridNav),
        SubNav(subNavList: this.homeModel.subNavList),
        SaleBoxNav(salesBox: this.homeModel.salesBox),
        _buildBottomHint(),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeHighLight : SearchBarType.home,
              enabled: false,
              hideLeft: false,
              inputBoxClick: _jump2Search,
              speakClick: _jump2Speak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        ),
      ],
    );
  }

  Center _buildBottomHint() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 7),
        child: Text(
          '本APP由Milo完成',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ),
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
                        hideAppBar: true,
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

  _jump2Search() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Material(
        child: SearchPage(
          hint: SEARCH_BAR_DEFAULT_TEXT,
        ),
      );
    }));
  }

  _jump2Speak() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SpeakPage();
    }));
  }
}
