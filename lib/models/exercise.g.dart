// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    exerciseID: json['exerciseID'] as int,
    baseDuration: json['baseDuration'] as int,
    baseRepPerRound: json['baseRepPerRound'] as int,
    description: json['description'] as String,
    exerciseOrder: json['exerciseOrder'] as int,
    imageUrl: json['imageUrl'] as String,
    name: json['name'] as String,
    videoUrl: json['videoUrl'] as String,
    isChecked: json['isChecked'] as bool?,
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'exerciseID': instance.exerciseID,
      'baseDuration': instance.baseDuration,
      'baseRepPerRound': instance.baseRepPerRound,
      'description': instance.description,
      'exerciseOrder': instance.exerciseOrder,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'videoUrl': instance.videoUrl,
      'isChecked': instance.isChecked,
    };
