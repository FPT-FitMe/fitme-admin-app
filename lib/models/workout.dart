import 'package:json_annotation/json_annotation.dart';
part 'workout.g.dart';

@JsonSerializable()
class Workout {
  int workoutID;
  String description;
  double estimatedCalories;
  int estimatedDuration;
  String? imageUrl;
  bool isPremium;
  int level;
  String name;

  Workout({
    required this.workoutID,
    required this.description,
    required this.estimatedCalories,
    required this.estimatedDuration,
    this.imageUrl,
    required this.isPremium,
    required this.level,
    required this.name,
  });

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
