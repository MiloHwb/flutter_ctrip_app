import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/model/home_model.dart';

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
      child: Text(json.encode(gridNavModel)),
    );
  }
}
