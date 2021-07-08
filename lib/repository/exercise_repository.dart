import 'package:fitme_admin_app/models/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getAllExercises();
  Future<Exercise> addExercise(Exercise exercise);
  Future<Exercise> updateExercise(Exercise exercise);
  Future<int?> disableExercise(int id);
}
