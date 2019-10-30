import 'dart:math';

import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  TravelPage({Key key}) : super(key: key);

  @override
  _TravelPageState createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  test() async {
    var result = await Future.delayed(Duration(milliseconds: 2000), () {
      return Future.value(123);
    });

    print('t3: ' + DateTime.now().toString());

    print(result);
  }

  test2() {
    Future.delayed(Duration(milliseconds: 2000), () {
      if (Random().nextBool()) {
        return Future.value(200);
      } else {
        throw 'Boom!';
      }
    })
    .timeout(Duration(milliseconds: 1500))
        .then(print)
        .catchError((error) {
      print(error);
    }).whenComplete(() {
      print('Done!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          onPressed: () {
//            print('t1: ' + DateTime.now().toString());
//            test();
//            print('t2: ' + DateTime.now().toString());
            test2();
          },
          child: Text('点击'),
        ),
      ),
    );
  }
}
