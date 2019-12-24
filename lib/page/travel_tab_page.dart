import 'package:flutter/material.dart';
import 'package:flutter_ctrip_app/dao/travel_dao.dart';
import 'package:flutter_ctrip_app/model/travel_model.dart';
import 'package:flutter_ctrip_app/widget/loading_container.dart';
import 'package:flutter_ctrip_app/widget/webview.dart';
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

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool isLoading = true;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    _loadData();
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: isLoading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: StaggeredGridView.countBuilder(
            controller: _controller,
            crossAxisCount: 2,
            itemCount: travelItems?.length ?? 0,
            itemBuilder: (BuildContext context, int index) =>
                _TravelItem(travelItem: travelItems[index], index: index),
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          ),
        ),
      ),
    );
  }

  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    TravelDao.fetch(widget.travelUrl ?? TRAVEL_URL, widget.groupChannelCode, pageIndex, PAGE_SIZE)
        .then((TravelModel model) {
      setState(() {
        isLoading = false;
        List<TravelItem> items = _filterItems(model.resultList);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
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

  @override
  bool get wantKeepAlive => true;

  Future<Null> _handleRefresh() {
    pageIndex = 1;
    _loadData();
    return Future.value(null);
  }
}

class _TravelItem extends StatelessWidget {
  final TravelItem travelItem;

  final int index;

  _TravelItem({Key key, this.travelItem, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (travelItem != null &&
            travelItem.article.urls != null &&
            travelItem.article.urls.length != 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return WebView(
              url: travelItem.article.urls[0].h5Url,
              title: '详情',
            );
          }));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageItem(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  travelItem.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageItem() {
    return Stack(
      children: <Widget>[
        Image.network(travelItem.article.images[0]?.dynamicUrl),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _poiName() {
    return travelItem.article.poiName == null || travelItem.article.pois.length == 0
        ? '未知'
        : travelItem.article.pois[0]?.poiName ?? '未知';
  }

  Widget _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  travelItem.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  travelItem.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  travelItem.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
