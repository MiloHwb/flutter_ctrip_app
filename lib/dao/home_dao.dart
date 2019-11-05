import 'dart:convert';

import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    Response response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      var utf8decoder = Utf8Decoder(); //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Home接口请求失败');
    }
  }
}
