import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/workout.dart';

abstract class DetailWorkoutView {
  void showSuccessModal(Workout workout, String message);
  void updateImageUrl(String? imageUrl);
  void showFailedModal(String message);
  void backToWorkoutScreen(int? deletedMealID);
  void loadCoaches(List<Coach> listCoaches);
}
