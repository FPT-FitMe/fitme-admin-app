import 'package:fitme_admin_app/models/workout.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getAllWorkouts();
  Future<Workout> addWorkout(Workout workout);
  Future<Workout> updateWorkout(Workout workout);
  Future<int?> disableWorkout(int id);
}
