import 'package:fitme_admin_app/models/meal.dart';

abstract class MealRepository {
  Future<List<Meal>> getAllMeals();
  Future<Meal> addMeal(Meal meal);
  Future<Meal> updateMeal(Meal meal);
  Future<int?> disableMeal(int id);
}
