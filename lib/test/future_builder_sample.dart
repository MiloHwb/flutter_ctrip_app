import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/test/commone_model.dart';
import 'package:http/http.dart' as http;

class FutureBuilderSample extends StatefulWidget {
  FutureBuilderSample({Key key}) : super(key: key);

  @override
  _FutureBuilderSampleState createState() {
    return _FutureBuilderSampleState();
  }
}

class _FutureBuilderSampleState extends State<FutureBuilderSample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<CommonModel> fetchPost() async {
    var response =
        await http.get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    var utf8decoder = Utf8Decoder(); //修复中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Future与FutureBuilder使用技巧'),
        ),
        body: FutureBuilder(
          future: fetchPost(),
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Input a URL to start');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      // ignore: missing_return
                      Text('icon: ${snapshot.data.icon}'),
                      Text('statusBarColor: ${snapshot.data.statusBarColor}'),
                      Text('title: ${snapshot.data.title}'),
                      Text('url: ${snapshot.data.url}'),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
