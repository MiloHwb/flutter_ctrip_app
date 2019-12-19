import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/travel_tab_dao.dart';
import 'package:flutter_ctrip_app/model/travel_model.dart';
import 'package:flutter_ctrip_app/model/travel_tab_model.dart';
import 'package:flutter_ctrip_app/page/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        this.tabs = model.tabs;
        this.travelTabModel = model;
      });
    }).catchError((e) {
      print(e.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Color(0xff2fcfbb),
                    width: 3,
                  ),
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 5),
                ),
                tabs: this.tabs.map((TravelTab tab) {
                  return Tab(text: tab.labelName);
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: this.tabs.map((TravelTab tab) {
                  return TravelTabPage(
                    travelUrl: travelTabModel.url,
                    groupChannelCode: tab.groupChannelCode,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
