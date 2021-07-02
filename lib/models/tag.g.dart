// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    tagID: json['tagID'] as int,
    name: json['name'] as String,
    type: json['type'] as int,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'tagID': instance.tagID,
      'name': instance.name,
      'type': instance.type,
    };
