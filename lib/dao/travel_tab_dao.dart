import 'dart:convert';

import 'package:flutter_ctrip_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const TRAVEL_TAB_URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    Response response = await http.get(TRAVEL_TAB_URL);
    if (response.statusCode == 200) {
      var utf8decoder = Utf8Decoder(); //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('TravelTab接口请求失败');
    }
  }
}
