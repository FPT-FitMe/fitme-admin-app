import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/repository/exercise_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/DetailExerciseScreen/detail_exercise_view.dart';

class DetailExercisePresenter {
  DetailExerciseView _detailMealView;
  late ExerciseRepository _exerciseRepository;
  late ImageRepository _imageRepository;
  late TagRepository _tagRepository;

  DetailExercisePresenter(this._detailMealView) {
    _exerciseRepository = new Injector().exerciseRepository;
    _imageRepository = new Injector().exerciseImageRepository;
    _tagRepository = new Injector().tagRepository;
  }

  void uploadImage(String imagePath, bool isGif) async {
    try {
      String? imageUrl = await _imageRepository.uploadImage(imagePath);
      if (isGif) {
        _detailMealView.updateVideoUrl(imageUrl);
      } else {
        _detailMealView.updateImageUrl(imageUrl);
      }
    } catch (e) {
      print(e);
      _detailMealView.showFailedModal("Lỗi khi upload ảnh");
    }
  }

  void addExercise(Exercise exercise) async {
    try {
      Exercise addedExercise = await _exerciseRepository.addExercise(exercise);
      _detailMealView.showSuccessModal(
          addedExercise, "Thêm ${addedExercise.name} thành công");
    } catch (e) {
      print(e);
      _detailMealView.showFailedModal("Lỗi khi thêm món ăn");
    }
  }

  void updateExercise(Exercise exercise) async {
    try {
      Exercise updatedExercise =
          await _exerciseRepository.updateExercise(exercise);
      _detailMealView.showSuccessModal(
          updatedExercise, "Cập nhật ${exercise.name} thành công");
    } catch (e) {
      print(e);
    }
  }

  void deleteExercise(int id) async {
    try {
      int? deletedExerciseID = await _exerciseRepository.disableExercise(id);
      _detailMealView.backToExerciseScreen(deletedExerciseID);
    } catch (e) {
      print(e);
    }
  }

  void loadMealTags() async {
    try {
      List<Tag> listTags = await _tagRepository.getTagByType(TagTypes.exercise);
      _detailMealView.loadTags(listTags);
    } catch (e) {
      print(e);
    }
  }
}
