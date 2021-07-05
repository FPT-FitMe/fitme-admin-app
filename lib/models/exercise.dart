import 'package:json_annotation/json_annotation.dart';
part 'exercise.g.dart';

@JsonSerializable()
class Exercise {
  int exerciseID;
  int baseDuration;
  int baseRepPerRound;
  String description;
  int exerciseOrder;
  String imageUrl;
  String name;
  String videoUrl;
  bool? isChecked;

  Exercise({
    required this.exerciseID,
    required this.baseDuration,
    required this.baseRepPerRound,
    required this.description,
    required this.exerciseOrder,
    required this.imageUrl,
    required this.name,
    required this.videoUrl,
    this.isChecked = false,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}
