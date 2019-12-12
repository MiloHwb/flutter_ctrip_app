import 'package:json_annotation/json_annotation.dart';

part 'travel_tab_model.g.dart';

///旅拍类别model
@JsonSerializable()
class TravelTabModel {
  String url;
  List<TravelTab> tabs;

  TravelTabModel({this.url, this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) => _$TravelTabModelFromJson(json);

  Map<String, dynamic> toJson() => _$TravelTabModelToJson(this);
}

@JsonSerializable()
class TravelTab {
  String labelName;
  String groupChannelCode;

  TravelTab({this.labelName, this.groupChannelCode});

  factory TravelTab.fromJson(Map<String, dynamic> json) => _$TravelTabFromJson(json);

  Map<String, dynamic> toJson() => _$TravelTabToJson(this);
}
