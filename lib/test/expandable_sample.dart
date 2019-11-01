import 'package:flutter/material.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/11/1 20:19
 * @ 描述         
 */

const CITY_NAMES = {
  '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
  '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
  '广州': ['越秀区', '海珠区', '荔湾区', '天河区', '白云区', '黄浦区', '南沙区', '番禺区'],
  '深圳': ['南山区', '福田区', '罗湖区', '盐田区', '龙岗区', '宝安区', '滨江区'],
  '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
  '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区'],
};

class ExpandableSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '列表的展开与收起',
      home: Scaffold(
        appBar: AppBar(
          title: Text('列表的展开与收起'),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    CITY_NAMES.forEach((String city, List<String> regions) {
      widgets.add(_item(city, regions));
    });

    return widgets;
  }

  Widget _item(String city, List<String> regions) {
    return ExpansionTile(
      title: Text(
        city,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 20,
        ),
      ),
      children: regions.map((region) => _buildRegion(region)).toList(),
    );
  }

  Widget _buildRegion(String region) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.lightBlueAccent),
        child: Center(
          child: Text(region),
        ),
      ),
    );
  }
}
