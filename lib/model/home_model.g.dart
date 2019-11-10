// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    config: json['config'] == null
        ? null
        : ConfigModel.fromJson(json['config'] as Map<String, dynamic>),
    bannerList: (json['bannerList'] as List)
        ?.map((e) =>
            e == null ? null : CommonModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    localNavList: (json['localNavList'] as List)
        ?.map((e) =>
            e == null ? null : CommonModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    gridNav: json['gridNav'] == null
        ? null
        : GridNavModel.fromJson(json['gridNav'] as Map<String, dynamic>),
    subNavList: (json['subNavList'] as List)
        ?.map((e) =>
            e == null ? null : CommonModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    salesBox: json['salesBox'] == null
        ? null
        : SalesBoxModel.fromJson(json['salesBox'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'config': instance.config,
      'bannerList': instance.bannerList,
      'localNavList': instance.localNavList,
      'gridNav': instance.gridNav,
      'subNavList': instance.subNavList,
      'salesBox': instance.salesBox,
    };

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) {
  return ConfigModel(
    searchUrl: json['searchUrl'] as String,
  );
}

Map<String, dynamic> _$ConfigModelToJson(ConfigModel instance) =>
    <String, dynamic>{
      'searchUrl': instance.searchUrl,
    };

CommonModel _$CommonModelFromJson(Map<String, dynamic> json) {
  return CommonModel(
    icon: json['icon'] as String,
    title: json['title'] as String,
    url: json['url'] as String,
    statusBarColor: json['statusBarColor'] as String,
    hideAppBar: json['hideAppBar'] as bool,
  );
}

Map<String, dynamic> _$CommonModelToJson(CommonModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'title': instance.title,
      'url': instance.url,
      'statusBarColor': instance.statusBarColor,
      'hideAppBar': instance.hideAppBar,
    };

GridNavModel _$GridNavModelFromJson(Map<String, dynamic> json) {
  return GridNavModel(
    hotel: json['hotel'] == null
        ? null
        : GridNavItem.fromJson(json['hotel'] as Map<String, dynamic>),
    flight: json['flight'] == null
        ? null
        : GridNavItem.fromJson(json['flight'] as Map<String, dynamic>),
    travel: json['travel'] == null
        ? null
        : GridNavItem.fromJson(json['travel'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GridNavModelToJson(GridNavModel instance) =>
    <String, dynamic>{
      'hotel': instance.hotel,
      'flight': instance.flight,
      'travel': instance.travel,
    };

GridNavItem _$GridNavItemFromJson(Map<String, dynamic> json) {
  return GridNavItem(
    startColor: json['startColor'] as String,
    endColor: json['endColor'] as String,
    mainItem: json['mainItem'] == null
        ? null
        : CommonModel.fromJson(json['mainItem'] as Map<String, dynamic>),
    item1: json['item1'] == null
        ? null
        : CommonModel.fromJson(json['item1'] as Map<String, dynamic>),
    item2: json['item2'] == null
        ? null
        : CommonModel.fromJson(json['item2'] as Map<String, dynamic>),
    item3: json['item3'] == null
        ? null
        : CommonModel.fromJson(json['item3'] as Map<String, dynamic>),
    item4: json['item4'] == null
        ? null
        : CommonModel.fromJson(json['item4'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GridNavItemToJson(GridNavItem instance) =>
    <String, dynamic>{
      'startColor': instance.startColor,
      'endColor': instance.endColor,
      'mainItem': instance.mainItem,
      'item1': instance.item1,
      'item2': instance.item2,
      'item3': instance.item3,
      'item4': instance.item4,
    };

SalesBoxModel _$SalesBoxModelFromJson(Map<String, dynamic> json) {
  return SalesBoxModel(
    icon: json['icon'] as String,
    moreUrl: json['moreUrl'] as String,
    bigCard1: json['bigCard1'] == null
        ? null
        : CommonModel.fromJson(json['bigCard1'] as Map<String, dynamic>),
    bigCard2: json['bigCard2'] == null
        ? null
        : CommonModel.fromJson(json['bigCard2'] as Map<String, dynamic>),
    smallCard1: json['smallCard1'] == null
        ? null
        : CommonModel.fromJson(json['smallCard1'] as Map<String, dynamic>),
    smallCard2: json['smallCard2'] == null
        ? null
        : CommonModel.fromJson(json['smallCard2'] as Map<String, dynamic>),
    smallCard3: json['smallCard3'] == null
        ? null
        : CommonModel.fromJson(json['smallCard3'] as Map<String, dynamic>),
    smallCard4: json['smallCard4'] == null
        ? null
        : CommonModel.fromJson(json['smallCard4'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SalesBoxModelToJson(SalesBoxModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'moreUrl': instance.moreUrl,
      'bigCard1': instance.bigCard1,
      'bigCard2': instance.bigCard2,
      'smallCard1': instance.smallCard1,
      'smallCard2': instance.smallCard2,
      'smallCard3': instance.smallCard3,
      'smallCard4': instance.smallCard4,
    };
