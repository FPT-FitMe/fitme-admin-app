import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/tag.dart';

abstract class DetailExerciseView {
  void showSuccessModal(Exercise exercise, String message);
  void updateImageUrl(String? imageUrl);
  void updateVideoUrl(String? videoUrl);
  void showFailedModal(String message);
  void backToExerciseScreen(int? deletedExerciseID);
  void loadTags(List<Tag> listTags);
}
