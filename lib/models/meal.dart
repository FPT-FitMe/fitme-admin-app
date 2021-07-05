import 'package:json_annotation/json_annotation.dart';
part 'meal.g.dart';

@JsonSerializable()
class Meal {
  int mealID;
  double calories;
  double carbAmount;
  int cookingTime;
  String description;
  double fatAmount;
  String imageUrl;
  bool isPremium;
  String name;

  Meal({
    required this.mealID,
    required this.calories,
    required this.carbAmount,
    required this.cookingTime,
    required this.description,
    required this.fatAmount,
    required this.isPremium,
    this.imageUrl =
        "https://images.unsplash.com/photo-1518617840859-acd542e13a99?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=949&q=80",
    required this.name,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}
