// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelModel _$TravelModelFromJson(Map<String, dynamic> json) {
  return TravelModel(
    totalCount: json['totalCount'] as int,
    resultList: (json['resultList'] as List)
        ?.map((e) =>
            e == null ? null : TravelItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TravelModelToJson(TravelModel instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'resultList': instance.resultList,
    };

TravelItem _$TravelItemFromJson(Map<String, dynamic> json) {
  return TravelItem(
    type: json['type'] as int,
    article: json['article'] == null
        ? null
        : Article.fromJson(json['article'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TravelItemToJson(TravelItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'article': instance.article,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    sourceId: json['sourceId'] as int,
    shareInfo: json['shareInfo'] == null
        ? null
        : ShareInfo.fromJson(json['shareInfo'] as Map<String, dynamic>),
    isLike: json['isLike'] as bool,
    currentDate: json['currentDate'] as String,
    likeCount: json['likeCount'] as int,
    readCount: json['readCount'] as int,
    shootTime: json['shootTime'] as String,
    shareCount: json['shareCount'] as int,
    urls: (json['urls'] as List)
        ?.map((e) => e == null ? null : Url.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    distanceText: json['distanceText'] as String,
    pois: (json['pois'] as List)
        ?.map((e) => e == null ? null : Poi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productType: json['productType'] as int,
    hasVideo: json['hasVideo'] as bool,
    publishTime: json['publishTime'] as String,
    articleTitle: json['articleTitle'] as String,
    images: (json['images'] as List)
        ?.map(
            (e) => e == null ? null : ImageEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    level: json['level'] as int,
    poiName: json['poiName'] as String,
    author: json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    topics: (json['topics'] as List)
        ?.map(
            (e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    articleId: json['articleId'] as int,
    collectCount: json['collectCount'] as int,
    imageCounts: json['imageCounts'] as int,
    commentCount: json['commentCount'] as int,
    tags: (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    shootTimeDisplay: json['shootTimeDisplay'] as String,
    sourceType: json['sourceType'] as int,
    articleStatus: json['articleStatus'] as int,
    publishTimeDisplay: json['publishTimeDisplay'] as String,
    isCollected: json['isCollected'] as bool,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'sourceId': instance.sourceId,
      'shareInfo': instance.shareInfo,
      'isLike': instance.isLike,
      'currentDate': instance.currentDate,
      'likeCount': instance.likeCount,
      'readCount': instance.readCount,
      'shootTime': instance.shootTime,
      'shareCount': instance.shareCount,
      'urls': instance.urls,
      'distanceText': instance.distanceText,
      'pois': instance.pois,
      'productType': instance.productType,
      'hasVideo': instance.hasVideo,
      'publishTime': instance.publishTime,
      'articleTitle': instance.articleTitle,
      'images': instance.images,
      'level': instance.level,
      'poiName': instance.poiName,
      'author': instance.author,
      'topics': instance.topics,
      'articleId': instance.articleId,
      'collectCount': instance.collectCount,
      'imageCounts': instance.imageCounts,
      'commentCount': instance.commentCount,
      'tags': instance.tags,
      'shootTimeDisplay': instance.shootTimeDisplay,
      'sourceType': instance.sourceType,
      'articleStatus': instance.articleStatus,
      'publishTimeDisplay': instance.publishTimeDisplay,
      'isCollected': instance.isCollected,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    parentTagId: json['parentTagId'] as int,
    tagId: json['tagId'] as int,
    sortIndex: json['sortIndex'] as int,
    source: json['source'] as int,
    tagName: json['tagName'] as String,
    tagLevel: json['tagLevel'] as int,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'parentTagId': instance.parentTagId,
      'tagId': instance.tagId,
      'sortIndex': instance.sortIndex,
      'source': instance.source,
      'tagName': instance.tagName,
      'tagLevel': instance.tagLevel,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
    topicId: json['topicId'] as int,
    level: json['level'] as int,
    topicName: json['topicName'] as String,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'topicId': instance.topicId,
      'level': instance.level,
      'topicName': instance.topicName,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    followCount: json['followCount'] as int,
    identityType: json['identityType'] as int,
    nickName: json['nickName'] as String,
    coverImage: json['coverImage'] == null
        ? null
        : CoverImage.fromJson(json['coverImage'] as Map<String, dynamic>),
    identityTypeName: json['identityTypeName'] as String,
    tag: json['tag'] as String,
    authorId: json['authorId'] as int,
    clientAuth: json['clientAuth'] as String,
    jumpUrl: json['jumpUrl'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'followCount': instance.followCount,
      'identityType': instance.identityType,
      'nickName': instance.nickName,
      'coverImage': instance.coverImage,
      'identityTypeName': instance.identityTypeName,
      'tag': instance.tag,
      'authorId': instance.authorId,
      'clientAuth': instance.clientAuth,
      'jumpUrl': instance.jumpUrl,
    };

CoverImage _$CoverImageFromJson(Map<String, dynamic> json) {
  return CoverImage(
    originalUrl: json['originalUrl'] as String,
    dynamicUrl: json['dynamicUrl'] as String,
  );
}

Map<String, dynamic> _$CoverImageToJson(CoverImage instance) =>
    <String, dynamic>{
      'originalUrl': instance.originalUrl,
      'dynamicUrl': instance.dynamicUrl,
    };

ImageEntity _$ImageFromJson(Map<String, dynamic> json) {
  return ImageEntity(
    isWaterMarked: json['isWaterMarked'] as bool,
    imageId: json['imageId'] as int,
    width: json['width'] as num,
    mediaType: json['mediaType'] as int,
    lon: json['lon'] as double,
    originalUrl: json['originalUrl'] as String,
    dynamicUrl: json['dynamicUrl'] as String,
    lat: json['lat'] as double,
    height: json['height'] as num,
  );
}

Map<String, dynamic> _$ImageToJson(ImageEntity instance) => <String, dynamic>{
      'isWaterMarked': instance.isWaterMarked,
      'imageId': instance.imageId,
      'width': instance.width,
      'mediaType': instance.mediaType,
      'lon': instance.lon,
      'originalUrl': instance.originalUrl,
      'dynamicUrl': instance.dynamicUrl,
      'lat': instance.lat,
      'height': instance.height,
    };

Poi _$PoiFromJson(Map<String, dynamic> json) {
  return Poi(
    districtId: json['districtId'] as int,
    districtName: json['districtName'] as String,
    poiName: json['poiName'] as String,
    isMain: json['isMain'] as int,
    poiType: json['poiType'] as int,
    districtENName: json['districtENName'] as String,
    poiId: json['poiId'] as int,
    source: json['source'] as int,
    poiExt: json['poiExt'] == null
        ? null
        : PoiExt.fromJson(json['poiExt'] as Map<String, dynamic>),
    isInChina: json['isInChina'] as bool,
  );
}

Map<String, dynamic> _$PoiToJson(Poi instance) => <String, dynamic>{
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'poiName': instance.poiName,
      'isMain': instance.isMain,
      'poiType': instance.poiType,
      'districtENName': instance.districtENName,
      'poiId': instance.poiId,
      'source': instance.source,
      'poiExt': instance.poiExt,
      'isInChina': instance.isInChina,
    };

PoiExt _$PoiExtFromJson(Map<String, dynamic> json) {
  return PoiExt(
    h5Url: json['h5Url'] as String,
    appUrl: json['appUrl'] as String,
  );
}

Map<String, dynamic> _$PoiExtToJson(PoiExt instance) => <String, dynamic>{
      'h5Url': instance.h5Url,
      'appUrl': instance.appUrl,
    };

Url _$UrlFromJson(Map<String, dynamic> json) {
  return Url(
    h5Url: json['h5Url'] as String,
    appUrl: json['appUrl'] as String,
    wxUrl: json['wxUrl'] as String,
    version: json['version'] as String,
  );
}

Map<String, dynamic> _$UrlToJson(Url instance) => <String, dynamic>{
      'h5Url': instance.h5Url,
      'appUrl': instance.appUrl,
      'wxUrl': instance.wxUrl,
      'version': instance.version,
    };

ShareInfo _$ShareInfoFromJson(Map<String, dynamic> json) {
  return ShareInfo(
    shareContent: json['shareContent'] as String,
    shareTitle: json['shareTitle'] as String,
    imageUrl: json['imageUrl'] as String,
    platForm: json['platForm'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$ShareInfoToJson(ShareInfo instance) => <String, dynamic>{
      'shareContent': instance.shareContent,
      'shareTitle': instance.shareTitle,
      'imageUrl': instance.imageUrl,
      'platForm': instance.platForm,
      'token': instance.token,
    };
