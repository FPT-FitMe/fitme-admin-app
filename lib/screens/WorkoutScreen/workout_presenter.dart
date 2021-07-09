import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/repository/workout_repository.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/workout_view.dart';

class WorkoutPresenter {
  WorkoutView _workoutView;
  late WorkoutRepository _workoutRepository;

  WorkoutPresenter(this._workoutView) {
    _workoutRepository = new Injector().workoutRepository;
  }

  void loadAllWorkouts() async {
    // try {
    List<Workout> listWorkouts = await _workoutRepository.getAllWorkouts();
    _workoutView.loadWorkouts(listWorkouts);
    // } catch (e) {
    // _workoutView.showEmptyList();
    // print(e);
    // }
  }

  void deleteWorkout(int id) async {
    try {
      await _workoutRepository.disableWorkout(id);
      _workoutView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
