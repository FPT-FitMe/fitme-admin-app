import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/models/tag.dart';

abstract class DetailMealView {
  void showSuccessModal(Meal meal, String message);
  void updateImageUrl(String? imageUrl);
  void showFailedModal(String message);
  void backToMealScreen(int? deletedMealID);
  void loadCoaches(List<Coach> listCoaches);
  void loadTags(List<Tag> listTags);
}
