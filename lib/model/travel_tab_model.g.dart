// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelTabModel _$TravelTabModelFromJson(Map<String, dynamic> json) {
  return TravelTabModel(
    url: json['url'] as String,
    tabs: (json['tabs'] as List)
        ?.map((e) =>
            e == null ? null : TravelTab.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TravelTabModelToJson(TravelTabModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'tabs': instance.tabs,
    };

TravelTab _$TravelTabFromJson(Map<String, dynamic> json) {
  return TravelTab(
    labelName: json['labelName'] as String,
    groupChannelCode: json['groupChannelCode'] as String,
  );
}

Map<String, dynamic> _$TravelTabToJson(TravelTab instance) => <String, dynamic>{
      'labelName': instance.labelName,
      'groupChannelCode': instance.groupChannelCode,
    };
