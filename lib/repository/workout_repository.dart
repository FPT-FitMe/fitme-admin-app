import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';

abstract class WorkoutRepository {
  Future<List<Workout>> getAllWorkouts();
  Future<Workout> addWorkout(Workout workout);
  Future<Workout> updateWorkout(Workout workout);
  Future<int?> disableWorkout(int id);
  Future<List<WorkoutExercise>> getListExerciseOfWorkout(int workoutID);
  Future<List<WorkoutExercise>> updateListExerciseOfWorkout(
      int workoutID, List<Exercise> exercises);
  Future<List<WorkoutExercise>> createListExerciseOfWorkout(
      int workoutID, List<Exercise> exercises);
}
