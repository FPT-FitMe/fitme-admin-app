import 'package:fitme_admin_app/models/workout.dart';

abstract class WorkoutView {
  void loadWorkouts(List<Workout> listWorkouts);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
}
