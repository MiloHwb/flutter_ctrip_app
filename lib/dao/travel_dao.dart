import 'dart:convert';

import 'package:flutter_ctrip_app/model/travel_model.dart';
import 'package:flutter_ctrip_app/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Map params = {
  'districtId': -1,
  'groupChannelCode': "RX-OMF",
  'type': null,
  'lat': -180,
  'lon': -180,
  'locatedDistrictId': 0,
  'pagePara': {"pageIndex": 1, "pageSize": 10, "sortType": 9, "sortDirection": 0},
  'imageCutType': 1,
  'head': {},
  'contentType': "json"
};

///旅拍页接口
class TravelDao {
  static Future<TravelModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {

    params['groupChannelCode'] = groupChannelCode;
    Map paramMap = params['pagePara'];
    paramMap['pageIndex'] = pageIndex;
    paramMap['pageSize'] = pageSize;
    Response response = await http.post(url, body: jsonEncode(params));

    if (response.statusCode == 200) {
      var utf8decoder = Utf8Decoder(); //修复中文乱码
      var resultString = utf8decoder.convert(response.bodyBytes);
      var result = json.decode(resultString);
      print(resultString);
      return TravelModel.fromJson(result);
    } else {
      throw Exception('Travel接口请求失败');
    }
  }
}
