import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/workout_repository.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/DetailWorkoutScreen/detail_workout_view.dart';

class DetailWorkoutPresenter {
  DetailWorkoutView _detailWorkoutView;
  late WorkoutRepository _workoutRepository;
  late CoachRepository _coachRepository;
  late ImageRepository _imageRepository;

  DetailWorkoutPresenter(this._detailWorkoutView) {
    _workoutRepository = new Injector().workoutRepository;
    _imageRepository = new Injector().workoutImageRepository;
    _coachRepository = new Injector().coachRepository;
  }

  void uploadImage(String imagePath) async {
    try {
      String? imageUrl = await _imageRepository.uploadImage(imagePath);
      _detailWorkoutView.updateImageUrl(imageUrl);
    } catch (e) {
      print(e);
      _detailWorkoutView.showFailedModal("Lỗi khi upload ảnh");
    }
  }

  void addWorkout(Workout workout) async {
    try {
      Workout addedWorkout = await _workoutRepository.addWorkout(workout);
      _detailWorkoutView.showSuccessModal(
          addedWorkout, "Thêm ${addedWorkout.name} thành công");
    } catch (e) {
      print(e);
      _detailWorkoutView.showFailedModal("Lỗi khi thêm khóa tập");
    }
  }

  void updateWorkout(Workout workout) async {
    try {
      Workout updatedWorkout = await _workoutRepository.updateWorkout(workout);
      _detailWorkoutView.showSuccessModal(
          updatedWorkout, "Cập nhật ${workout.name} thành công");
    } catch (e) {
      print(e);
    }
  }

  void deleteWorkout(int id) async {
    try {
      int? deletedMealID = await _workoutRepository.disableWorkout(id);
      _detailWorkoutView.backToWorkoutScreen(deletedMealID);
    } catch (e) {
      print(e);
    }
  }

  void loadAllCoaches() async {
    try {
      List<Coach> listCoaches = await _coachRepository.getAllCoaches();
      _detailWorkoutView.loadCoaches(listCoaches);
    } catch (e) {
      print(e);
    }
  }
}
