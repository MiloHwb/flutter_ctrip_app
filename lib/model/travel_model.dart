import 'package:json_annotation/json_annotation.dart';

part 'travel_model.g.dart';

///旅拍页模型
@JsonSerializable()
class TravelModel {
  int totalCount;
  List<TravelItem> resultList;

  TravelModel({this.totalCount, this.resultList});

  factory TravelModel.fromJson(Map<String, dynamic> json) => _$TravelModelFromJson(json);

  Map<String, dynamic> toJson() => _$TravelModelToJson(this);
}

@JsonSerializable()
class TravelItem {
  int type;
  Article article;

  TravelItem({this.type, this.article});

  factory TravelItem.fromJson(Map<String, dynamic> json) => _$TravelItemFromJson(json);

  Map<String, dynamic> toJson() => _$TravelItemToJson(this);
}

@JsonSerializable()
class Article {
  int sourceId;
  ShareInfo shareInfo;
  bool isLike;
  String currentDate;
  int likeCount;
  int readCount;
  String shootTime;
  int shareCount;
  List<Url> urls;
  String distanceText;
  List<Poi> pois;
  int productType;
  bool hasVideo;
  String publishTime;
  String articleTitle;
  List<Image> images;
  int level;
  String poiName;
  Author author;
  List<Topic> topics;
  int articleId;
  int collectCount;
  int imageCounts;
  int commentCount;
  List<Tag> tags;
  String shootTimeDisplay;
  int sourceType;
  int articleStatus;
  String publishTimeDisplay;
  bool isCollected;

  Article(
      {this.sourceId,
      this.shareInfo,
      this.isLike,
      this.currentDate,
      this.likeCount,
      this.readCount,
      this.shootTime,
      this.shareCount,
      this.urls,
      this.distanceText,
      this.pois,
      this.productType,
      this.hasVideo,
      this.publishTime,
      this.articleTitle,
      this.images,
      this.level,
      this.poiName,
      this.author,
      this.topics,
      this.articleId,
      this.collectCount,
      this.imageCounts,
      this.commentCount,
      this.tags,
      this.shootTimeDisplay,
      this.sourceType,
      this.articleStatus,
      this.publishTimeDisplay,
      this.isCollected});

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Tag {
  int parentTagId;
  int tagId;
  int sortIndex;
  int source;
  String tagName;
  int tagLevel;

  Tag({this.parentTagId, this.tagId, this.sortIndex, this.source, this.tagName, this.tagLevel});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}

@JsonSerializable()
class Topic {
  int topicId;
  int level;
  String topicName;

  Topic({this.topicId, this.level, this.topicName});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Author {
  int followCount;
  int identityType;
  String nickName;
  CoverImage coverImage;
  String identityTypeName;
  String tag;
  int authorId;
  String clientAuth;
  String jumpUrl;

  Author(
      {this.followCount,
      this.identityType,
      this.nickName,
      this.coverImage,
      this.identityTypeName,
      this.tag,
      this.authorId,
      this.clientAuth,
      this.jumpUrl});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}

@JsonSerializable()
class CoverImage {
  String originalUrl;
  String dynamicUrl;

  CoverImage({this.originalUrl, this.dynamicUrl});

  factory CoverImage.fromJson(Map<String, dynamic> json) => _$CoverImageFromJson(json);

  Map<String, dynamic> toJson() => _$CoverImageToJson(this);
}

@JsonSerializable()
class Image {
  bool isWaterMarked;
  int imageId;
  num width;
  int mediaType;
  double lon;
  String originalUrl;
  String dynamicUrl;
  double lat;
  num height;

  Image(
      {this.isWaterMarked,
      this.imageId,
      this.width,
      this.mediaType,
      this.lon,
      this.originalUrl,
      this.dynamicUrl,
      this.lat,
      this.height});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

@JsonSerializable()
class Poi {
  int districtId;
  String districtName;
  String poiName;
  int isMain;
  int poiType;
  String districtENName;
  int poiId;
  int source;
  PoiExt poiExt;
  bool isInChina;

  Poi(
      {this.districtId,
      this.districtName,
      this.poiName,
      this.isMain,
      this.poiType,
      this.districtENName,
      this.poiId,
      this.source,
      this.poiExt,
      this.isInChina});

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);

  Map<String, dynamic> toJson() => _$PoiToJson(this);
}

@JsonSerializable()
class PoiExt {
  String h5Url;
  String appUrl;

  PoiExt({this.h5Url, this.appUrl});

  factory PoiExt.fromJson(Map<String, dynamic> json) => _$PoiExtFromJson(json);

  Map<String, dynamic> toJson() => _$PoiExtToJson(this);
}

@JsonSerializable()
class Url {
  String h5Url;
  String appUrl;
  String wxUrl;
  String version;

  Url({this.h5Url, this.appUrl, this.wxUrl, this.version});

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);

  Map<String, dynamic> toJson() => _$UrlToJson(this);
}

@JsonSerializable()
class ShareInfo {
  String shareContent;
  String shareTitle;
  String imageUrl;
  String platForm;
  String token;

  ShareInfo({this.shareContent, this.shareTitle, this.imageUrl, this.platForm, this.token});

  factory ShareInfo.fromJson(Map<String, dynamic> json) => _$ShareInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ShareInfoToJson(this);
}
