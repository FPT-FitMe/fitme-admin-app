import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/meal_repository.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';
import 'package:fitme_admin_app/screens/MealScreen/DetailMealScreen/detail_meal_view.dart';

class DetailMealPresenter {
  DetailMealView _detailMealView;
  late MealRepository _mealRepository;
  late CoachRepository _coachRepository;
  late ImageRepository _imageRepository;
  late TagRepository _tagRepository;

  DetailMealPresenter(this._detailMealView) {
    _mealRepository = new Injector().mealRepository;
    _imageRepository = new Injector().mealImageRepository;
    _coachRepository = new Injector().coachRepository;
    _tagRepository = new Injector().tagRepository;
  }

  void uploadImage(String imagePath) async {
    try {
      String? imageUrl = await _imageRepository.uploadImage(imagePath);
      _detailMealView.updateImageUrl(imageUrl);
    } catch (e) {
      print(e);
      _detailMealView.showFailedModal("Lỗi khi upload ảnh");
    }
  }

  void addMeal(Meal meal) async {
    try {
      Meal addedMeal = await _mealRepository.addMeal(meal);
      _detailMealView.showSuccessModal(
          addedMeal, "Thêm ${meal.name} thành công");
    } catch (e) {
      print(e);
      _detailMealView.showFailedModal("Lỗi khi thêm món ăn");
    }
  }

  void updateMeal(Meal meal) async {
    try {
      Meal updatedMeal = await _mealRepository.updateMeal(meal);
      _detailMealView.showSuccessModal(
          updatedMeal, "Cập nhật ${meal.name} thành công");
    } catch (e) {
      print(e);
    }
  }

  void deleteMeal(int id) async {
    try {
      int? deletedMealID = await _mealRepository.disableMeal(id);
      _detailMealView.backToMealScreen(deletedMealID);
    } catch (e) {
      print(e);
    }
  }

  void loadAllCoaches() async {
    try {
      List<Coach> listCoaches = await _coachRepository.getAllCoaches();
      _detailMealView.loadCoaches(listCoaches);
    } catch (e) {
      print(e);
    }
  }

  void loadMealTags() async {
    try {
      List<Tag> listTags = await _tagRepository.getTagByType(TagTypes.meal);
      _detailMealView.loadTags(listTags);
    } catch (e) {
      print(e);
    }
  }
}
