// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    postID: json['postID'] as int,
    contentBody: json['contentBody'] as String,
    contentHeader: json['contentHeader'] as String,
    imageUrl: json['imageUrl'] as String,
    readingTime: json['readingTime'] as int,
    isActive: json['isActive'] as bool,
    name: json['name'] as String,
    coachProfile: Coach.fromJson(json['coachProfile'] as Map<String, dynamic>),
    createdDate: DateTime.parse(json['createdDate'] as String),
    lastUpdatedDate: DateTime.parse(json['lastUpdatedDate'] as String),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postID': instance.postID,
      'contentBody': instance.contentBody,
      'contentHeader': instance.contentHeader,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'readingTime': instance.readingTime,
      'isActive': instance.isActive,
      'createdDate': instance.createdDate.toIso8601String(),
      'lastUpdatedDate': instance.lastUpdatedDate.toIso8601String(),
      'coachProfile': instance.coachProfile,
    };
