import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';
import 'package:fitme_admin_app/repository/exercise_repository.dart';
import 'package:fitme_admin_app/repository/workout_repository.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/WorkoutExerciseScreen/workout_exercise_view.dart';

class WorkoutExercisePresenter {
  WorkoutExerciseView _workoutExerciseView;
  late WorkoutRepository _workoutRepository;
  late ExerciseRepository _exerciseRepository;

  WorkoutExercisePresenter(this._workoutExerciseView) {
    _workoutRepository = new Injector().workoutRepository;
    _exerciseRepository = new Injector().exerciseRepository;
  }

  void loadWorkoutExercises(int workoutID) async {
    try {
      List<WorkoutExercise> workoutExercises =
          await _workoutRepository.getListExerciseOfWorkout(workoutID);
      _workoutExerciseView.loadWorkoutExercises(workoutExercises);
    } catch (e) {
      print(e);
      _workoutExerciseView.showFailedModal("Lỗi khi load bài tập");
    }
  }

  void addExercisesToWorkout(int workoutID, List<Exercise> exercises) async {
    try {
      await _workoutRepository.createListExerciseOfWorkout(
          workoutID, exercises);
      _workoutExerciseView.showSuccessModal("Thêm bài tập thành công");
    } catch (e) {
      print(e);
      _workoutExerciseView.showFailedModal("Lỗi khi thêm bài tập");
    }
  }

  void updateExercisesInWorkout(int workoutID, List<Exercise> exercises) async {
    try {
      await _workoutRepository.updateListExerciseOfWorkout(
          workoutID, exercises);
      _workoutExerciseView.showSuccessModal("Cập nhật thành công");
    } catch (e) {
      print(e);
      _workoutExerciseView.showFailedModal("Lỗi khi cập nhật bài tập");
    }
  }

  void loadAllExercises() async {
    try {
      List<Exercise> listExercises =
          await _exerciseRepository.getAllExercises();
      _workoutExerciseView.loadExercises(listExercises);
    } catch (e) {
      _workoutExerciseView.showEmptyList();
      print(e);
    }
  }
}
