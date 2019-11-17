import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/search_dao.dart';
import 'package:flutter_ctrip_app/model/search_model.dart';
import 'package:flutter_ctrip_app/widget/search_bar.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  SearchPage({Key key, this.hideLeft = false, this.searchUrl, this.keyword, this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';
  SearchModel searchModel;
  String keyword;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _appBar(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: searchModel?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _item(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
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
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: () {
                Navigator.of(context).pop();
              },
              clearClick: () {
                _onTextChange('');
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  Widget _item(int index) {
    if (searchModel == null || searchModel.data == null) {
      return null;
    }
    var data = searchModel.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return WebView(
                url: data.url,
                title: '详情',
              );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Text('${data.word} ${data.districtname ?? ''} ${data.zonename ?? ''}'),
                ),
                Container(
                  width: 300,
                  child: Text('${data.price ?? ''} ${data.type ?? ''}'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      SearchDao.clear();
      setState(() {
        searchModel = null;
      });
      return;
    }
    SearchDao.fetch(text).then((SearchModel searchModel) {
      setState(() {
        print('searchText = ' + text);
        this.searchModel = searchModel;
      });
    }).catchError((e) {
      print(e.toString());

      //不能用Exception来接收参数，因为dart能抛出任意对象
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
