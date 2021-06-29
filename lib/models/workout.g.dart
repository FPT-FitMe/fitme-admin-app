// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    workoutID: json['workoutID'] as int,
    description: json['description'] as String,
    estimatedCalories: (json['estimatedCalories'] as num).toDouble(),
    estimatedDuration: json['estimatedDuration'] as int,
    imageUrl: json['imageUrl'] as String?,
    isPremium: json['isPremium'] as bool,
    level: json['level'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'workoutID': instance.workoutID,
      'description': instance.description,
      'estimatedCalories': instance.estimatedCalories,
      'estimatedDuration': instance.estimatedDuration,
      'imageUrl': instance.imageUrl,
      'isPremium': instance.isPremium,
      'level': instance.level,
      'name': instance.name,
    };