import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/search_dao.dart';
import 'package:flutter_ctrip_app/model/search_model.dart';
import 'package:flutter_ctrip_app/widget/search_bar.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../r.dart';

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
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(data.type)),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(data),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: subTitle(data),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _title(SearchItem data) {
    if (data == null) {
      return null;
    }
    var spans = <TextSpan>[];
    spans.addAll(_keywordTextSpans(data.word, keyword));
    spans.add(TextSpan(
      text: ' ' + (data.districtname ?? '') + ' ' + (data.zonename ?? ''),
      style: TextStyle(fontSize: 16, color: Colors.grey),
    ));

    return RichText(text: TextSpan(children: spans));
  }

  Widget subTitle(SearchItem data) {
    if (data == null) {
      return null;
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: data.price ?? '',
            style: TextStyle(fontSize: 16, color: Colors.orange),
          ),
          TextSpan(
            text:' '+ (data.star ?? ''),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Iterable<TextSpan> _keywordTextSpans(String word, String keyword) {
    var spans = <TextSpan>[];
    if (word == null || word.length == 0) {
      return spans;
    }

    var arr = word.split(keyword);
    var normalTextStyle = TextStyle(fontSize: 16, color: Colors.black87);
    var keywordTextStyle = TextStyle(fontSize: 16, color: Colors.orange);
    for (var value in arr) {
      if (value == null || value.length == 0) {
        spans.add(TextSpan(text: keyword, style: keywordTextStyle));
      } else {
        spans.add(TextSpan(text: value, style: normalTextStyle));
      }
    }

    return spans;
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
//      Fluttertoast.showToast(
//          msg: e.toString(),
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0);
    });
  }

  String _typeImage(String type) {
    switch (type) {
      case 'channelgroup':
        return R.imagesTypeChannelgroup;
      case 'channelgs':
        return R.imagesTypeChannelgs;
      case 'channelplane':
        return R.imagesTypeChannelplane;
      case 'channeltrain':
        return R.imagesTypeChanneltrain;
      case 'cruise':
        return R.imagesTypeCruise;
      case 'district':
        return R.imagesTypeDistrict;
      case 'food':
        return R.imagesTypeFood;
      case 'group':
        return R.imagesTypeGroup;
      case 'gs':
        return R.imagesTypeGs;
      case 'hotel':
        return R.imagesTypeHotel;
      case 'huodong':
        return R.imagesTypeHuodong;
      case 'plane':
        return R.imagesTypePlane;
      case 'shop':
        return R.imagesTypeShop;
      case 'sight':
        return R.imagesTypeSight;
      case 'ticket':
        return R.imagesTypeTicket;
      case 'train':
        return R.imagesTypeTrain;
      case 'travelgroup':
        return R.imagesTypeTravelgroup;
      default:
        return R.imagesTypeTravelgroup;
    }
  }
}
