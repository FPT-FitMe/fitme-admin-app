import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/repository/meal_repository.dart';

class MealService implements MealRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<Meal> addMeal(Meal meal) async {
    final response = await dio.post("/meals", data: jsonEncode(meal));
    return Meal.fromJson(response.data);
  }

  @override
  Future<int?> disableMeal(int id) async {
    final response = await dio.patch("/meals/$id", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? id : null;
  }

  @override
  Future<List<Meal>> getAllMeals() async {
    final response = await dio.get("/meals");
    return (response.data as List).map((meal) => Meal.fromJson(meal)).toList();
  }

  @override
  Future<Meal> updateMeal(Meal meal) async {
    final response =
        await dio.put("/meals/${meal.mealID}", data: jsonEncode(meal));
    return Meal.fromJson(response.data);
  }
}
