import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';

import 'webview.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/10 17:59
 * @ 描述         
 */
class SaleBoxNav extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SaleBoxNav({Key key, this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 7, 7, 7),
      child: PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            _iconTitle(context),
            _bigItem(context),
            _smallItem(context),
          ],
        ),
      ),
    );
  }

  Widget _smallItem(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _wrapGesture(
                  context,
                  salesBox.smallCard1,
                  Image.network(
                    salesBox.smallCard1.icon,
                  )),
            ),
            Expanded(
              child: _wrapGesture(
                  context,
                  salesBox.smallCard2,
                  Image.network(
                    salesBox.smallCard2.icon,
                  )),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: _wrapGesture(
                  context,
                  salesBox.smallCard3,
                  Image.network(
                    salesBox.smallCard3.icon,
                  )),
            ),
            Expanded(
              child: _wrapGesture(
                  context,
                  salesBox.smallCard4,
                  Image.network(
                    salesBox.smallCard4.icon,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bigItem(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _wrapGesture(
              context,
              salesBox.bigCard1,
              Image.network(
                salesBox.bigCard1.icon,
              )),
        ),
        Expanded(
          child: _wrapGesture(
              context,
              salesBox.bigCard2,
              Image.network(
                salesBox.bigCard2.icon,
              )),
        ),
      ],
    );
  }

  Widget _iconTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(
            salesBox.icon,
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.pinkAccent,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebView(
                          url: salesBox.moreUrl,
                          statusBarColor: null,
                          title: '获取更多福利',
                          hideAppBar: false,
                          backForbid: true,
                        )));
              },
              child: Row(
                children: <Widget>[
                  Text(
                    '获取更多福利',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
