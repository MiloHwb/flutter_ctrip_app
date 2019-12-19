import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/travel_dao.dart';
import 'package:flutter_ctrip_app/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/*
 * @ 创建者       milo
 * @ 创建时间     2019/12/18 14:33
 * @ 描述         
 */
const PAGE_SIZE = 10;
const TRAVEL_URL =
    "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  TravelTabPage({Key key, this.travelUrl, this.groupChannelCode}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        itemCount: travelItems?.length ?? 0,
        itemBuilder: (BuildContext context, int index) =>
            _TravelItem(travelItem: travelItems[index], index: index),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      ),
    );
  }

  void _loadData() {
    TravelDao.fetch(widget.travelUrl ?? TRAVEL_URL, widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((TravelModel model) {
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    List<TravelItem> filterItems = [];
    if (resultList == null) {
      return filterItems;
    }

    resultList.forEach((item) {
      if (item.article != null) {
        //移除article为空的model
        filterItems.add(item);
      }
    });
    return filterItems;
  }
}

class _TravelItem extends StatelessWidget {
  final TravelItem travelItem;

  final int index;

  _TravelItem({Key key, this.travelItem, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$index"),
    );
  }
}
