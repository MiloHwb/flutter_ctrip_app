import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel {
  HeadModel head;
  List<SearchItem> data;

  SearchModel({this.head, this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchModelToJson(this);
}

@JsonSerializable()
class SearchItem {
  String word;
  String type;
  String price;
  String star;
  String zonename;
  String districtname;
  String url;

  SearchItem(
      {this.word, this.type, this.price, this.star, this.zonename, this.districtname, this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchItemToJson(this);
}

@JsonSerializable()
class HeadModel {
  dynamic auth;
  num errcode;

  HeadModel({this.auth, this.errcode});

  factory HeadModel.fromJson(Map<String, dynamic> json) => _$HeadModelFromJson(json);

  Map<String, dynamic> toJson() => _$HeadModelToJson(this);
}
