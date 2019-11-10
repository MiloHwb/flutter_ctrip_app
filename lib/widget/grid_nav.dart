import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/6 21:11
 * @ 描述         
 */
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: Column(
          children: <Widget>[
            //酒店
            _gridNavItem(gridNavModel.hotel, context),
            //机票
            _gridNavItem(gridNavModel.flight, context),
            //旅游
            _gridNavItem(gridNavModel.travel, context),
          ],
        ),
      ),
    );
  }

  Widget _gridNavItem(GridNavItem item, BuildContext context) {
    if (item == null) {
      return null;
    }
    return Container(
      height: 88,
      margin: EdgeInsets.only(bottom: 2),
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(int.parse('0xff' + item.startColor)),
          Color(int.parse('0xff' + item.endColor))
        ]),
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: _mainItem(context, item.mainItem)),
          Expanded(child: _doubleItem(context, item.item1, item.item2, true)),
          Expanded(child: _doubleItem(context, item.item3, item.item4, true)),
        ],
      ),
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem, bool isCenterItem) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: _smallItem(context, topItem, true, isCenterItem),
        ),
        Expanded(
          child: _smallItem(context, bottomItem, false, isCenterItem),
        ),
      ],
    );
  }

  Widget _smallItem(BuildContext context, CommonModel model, bool first, bool isCenterItem) {
    var borderSide = BorderSide(width: 1, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          ),
        ),
        child: _wrapGesture(
            Center(
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            model,
            context),
      ),
    );
  }

  GestureDetector _wrapGesture(Widget widget, CommonModel model, BuildContext context) {
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

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: Alignment.bottomCenter,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        model,
        context);
  }
}
