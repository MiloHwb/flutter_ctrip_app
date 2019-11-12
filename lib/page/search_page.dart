import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SearchBar(
            hideLeft: true,
            defaultText: 'hah',
            hint: '123',
            leftButtonClick: () {},
            onChanged: (text) {},
          )
        ],
      ),
    );
  }
}
