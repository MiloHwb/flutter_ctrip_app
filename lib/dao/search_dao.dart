import 'dart:convert';

import 'package:flutter_ctrip_app/model/home_model.dart';
import 'package:flutter_ctrip_app/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

///搜索接口
class SearchDao {
  static final List<Client> clients = [];

  static Future<SearchModel> fetch(String searchText) async {
    clients.map((client) {
      client.close();
    });
    var client = http.Client();
    clients.add(client);

    Response response = await client.get(SEARCH_URL + searchText);
    if (response.statusCode == 200) {
      var utf8decoder = Utf8Decoder(); //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return SearchModel.fromJson(result);
    } else {
      throw Exception('Search接口请求失败');
    }
  }
}
