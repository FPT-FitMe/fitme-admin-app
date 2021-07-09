import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';

abstract class WorkoutExerciseView {
  void loadExercises(List<Exercise> listExercises);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
  void showSuccessModal(String message);
  void loadWorkoutExercises(List<WorkoutExercise> listWorkoutExercises);
}
