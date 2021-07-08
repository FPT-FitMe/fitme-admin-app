import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/repository/exercise_repository.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/exercise_view.dart';

class ExercisePresenter {
  ExerciseView _exerciseView;
  late ExerciseRepository _exerciseRepository;

  ExercisePresenter(this._exerciseView) {
    _exerciseRepository = new Injector().exerciseRepository;
  }

  void loadAllExercises() async {
    try {
      List<Exercise> listMeals = await _exerciseRepository.getAllExercises();
      _exerciseView.loadExercises(listMeals);
    } catch (e) {
      _exerciseView.showEmptyList();
      print(e);
    }
  }

  void deleteExercise(int id) async {
    try {
      await _exerciseRepository.disableExercise(id);
      _exerciseView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
