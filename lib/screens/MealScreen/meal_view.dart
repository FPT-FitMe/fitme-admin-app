import 'package:fitme_admin_app/models/meal.dart';

abstract class MealView {
  void loadMeals(List<Meal> listMeals);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
}
