import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/models/role.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int userID;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final int? age;
  final int? gender;
  final Role? role;
  final List<Workout> traineeFavoriteWorkouts;
  final List<Meal> traineeFavoriteMeals;
  final double? height;
  final int? dietPreferenceType;
  final int? exerciseFrequencyType;
  final double? workoutIntensity;
  final bool? isPremium;
  final String? profileImageUrl;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.age,
    this.gender,
    this.role,
    required this.traineeFavoriteMeals,
    required this.traineeFavoriteWorkouts,
    required this.profileImageUrl,
    this.height,
    this.dietPreferenceType,
    this.exerciseFrequencyType,
    this.workoutIntensity,
    this.isPremium,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
