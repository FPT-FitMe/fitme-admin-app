import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/repository/meal_repository.dart';
import 'package:fitme_admin_app/screens/MealScreen/meal_view.dart';

class MealPresenter {
  MealView _mealView;
  late MealRepository _mealRepository;

  MealPresenter(this._mealView) {
    _mealRepository = new Injector().mealRepository;
  }

  void loadAllMeals() async {
    try {
      List<Meal> listMeals = await _mealRepository.getAllMeals();
      _mealView.loadMeals(listMeals);
    } catch (e) {
      _mealView.showEmptyList();
      print(e);
    }
  }

  void deleteMeal(int id) async {
    try {
      await _mealRepository.disableMeal(id);
      _mealView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
