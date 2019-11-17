// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
    head: json['head'] == null
        ? null
        : HeadModel.fromJson(json['head'] as Map<String, dynamic>),
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : SearchItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'head': instance.head,
      'data': instance.data,
    };

SearchItem _$SearchItemFromJson(Map<String, dynamic> json) {
  return SearchItem(
    word: json['word'] as String,
    type: json['type'] as String,
    price: json['price'] as String,
    star: json['star'] as String,
    zonename: json['zonename'] as String,
    districtname: json['districtname'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$SearchItemToJson(SearchItem instance) =>
    <String, dynamic>{
      'word': instance.word,
      'type': instance.type,
      'price': instance.price,
      'star': instance.star,
      'zonename': instance.zonename,
      'districtname': instance.districtname,
      'url': instance.url,
    };

HeadModel _$HeadModelFromJson(Map<String, dynamic> json) {
  return HeadModel(
    auth: json['auth'],
    errcode: json['errcode'] as num,
  );
}

Map<String, dynamic> _$HeadModelToJson(HeadModel instance) => <String, dynamic>{
      'auth': instance.auth,
      'errcode': instance.errcode,
    };
