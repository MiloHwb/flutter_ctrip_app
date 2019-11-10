import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';

import 'webview.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/10 17:05
 * @ 描述         
 */
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, @required this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 3, 7, 0),
      decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: GridView.count(
        childAspectRatio: 1.3,
        padding: EdgeInsets.all(0),
        physics: new NeverScrollableScrollPhysics(),
        //增加
        shrinkWrap: true,
        //增加
        crossAxisCount: 5,
        children: _subNavItems(context),
      ),
    );
  }

  List<Widget> _subNavItems(BuildContext context) {
    return subNavList.map((model) {
      return _wrapGesture(
          context,
          model,
          Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  model.icon,
                  width: 24,
                  height: 24,
                ),
                Text(
                  model.title,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ));
    }).toList();
  }

  GestureDetector _wrapGesture(BuildContext context, CommonModel model, Widget widget) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  title: model.title,
                  hideAppBar: model.hideAppBar,
                  backForbid: true,
                )));
      },
      child: widget,
    );
  }
}
