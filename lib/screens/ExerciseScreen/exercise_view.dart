import 'package:fitme_admin_app/models/exercise.dart';

abstract class ExerciseView {
  void loadExercises(List<Exercise> listExercises);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
}
