import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/6 21:25
 * @ 描述         
 */
class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(7, 4, 7, 4),
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _items(BuildContext context) {
    if (localNavList == null) {
      return null;
    }
    List<Widget> list = localNavList.map((model) => item(model, context)).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
  }

  Widget item(CommonModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return WebView(
                url: model.url,
                statusBarColor: model.statusBarColor,
                title: model.url,
                hideAppBar: model.hideAppBar,
                backForbid: true,
              );
            },
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
