import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/AddExerciseDialog/add_workout_dialog.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/WorkoutExerciseScreen/workout_exercise_presenter.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/WorkoutExerciseScreen/workout_exercise_view.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  const WorkoutExerciseScreen({Key? key}) : super(key: key);

  @override
  _WorkoutExerciseScreenState createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen>
    implements WorkoutExerciseView {
  bool _isLoading = true;
  List<Exercise> _listSelectedExercises = [];
  List<Exercise> _allExercise = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late WorkoutExercisePresenter _presenter;
  late Workout _workout;
  bool _isUpdateWorkoutExercise = false;

  _WorkoutExerciseScreenState() {
    _presenter = new WorkoutExercisePresenter(this);
    _presenter.loadAllExercises();
  }

  @override
  void didChangeDependencies() {
    final Workout workout =
        ModalRoute.of(context)!.settings.arguments as Workout;
    setState(() {
      _workout = workout;
      _isUpdateWorkoutExercise = true;
    });
    _presenter.loadWorkoutExercises(int.parse(workout.workoutID.toString()));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_workout.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_isUpdateWorkoutExercise) {
                _presenter.updateExercisesInWorkout(
                    int.parse(_workout.workoutID.toString()),
                    _listSelectedExercises);
              } else {
                _presenter.addExercisesToWorkout(
                    int.parse(_workout.workoutID.toString()),
                    _listSelectedExercises);
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<Exercise>? selectedExercises = await showDialog(
            context: context,
            builder: (context) => AddExerciseDialog(
              allExercises: _allExercise,
              selectedExercises: _listSelectedExercises,
            ),
          );
          if (selectedExercises != null) {
            setState(() {
              _listSelectedExercises = selectedExercises;
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? LoadingScreen()
          : SmartRefresher(
              onRefresh: refresh,
              controller: _refreshController,
              child: _listSelectedExercises.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: ReorderableListView.builder(
                        itemBuilder: (context, index) =>
                            _createReorderableExercise(
                                _listSelectedExercises[index]),
                        itemCount: _listSelectedExercises.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final Exercise item =
                                _listSelectedExercises.removeAt(oldIndex);
                            _listSelectedExercises.insert(newIndex, item);
                          });
                        },
                      ),
                    )
                  : NoDataView(
                      title: "Hiện tại chưa có bài tập nào",
                    ),
            ),
    );
  }

  Widget _createReorderableExercise(Exercise exercise) {
    return ListTile(
      key: Key(exercise.exerciseID.toString()),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu),
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(exercise.imageUrl),
          ),
        ],
      ),
      title: Text(exercise.name),
      subtitle: Text(
          "${exercise.baseDuration} phút - ${exercise.baseRepPerRound} reps"),
    );
  }

  @override
  void loadExercises(List<Exercise> listExercises) {
    setState(() {
      _isLoading = false;
      this._allExercise = listExercises;
    });
  }

  @override
  void loadWorkoutExercises(List<WorkoutExercise> listExercises) {
    setState(() {
      _isLoading = false;
      this._listSelectedExercises = listExercises
          .map((workoutExercise) => workoutExercise.exerciseID)
          .toList();
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadWorkoutExercises(int.parse(_workout.workoutID.toString()));
    _presenter.loadAllExercises();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyList() {
    setState(() {
      _isLoading = false;
      _listSelectedExercises = [];
    });
    _refreshController.refreshCompleted();
  }

  @override
  void showFailedModal(String message) {
    setState(() {
      _isLoading = false;
    });
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      buttons: [],
    ).show();
  }

  @override
  void showSuccessModal(String message) {
    setState(() {
      _isLoading = false;
    });
    Alert(
      context: context,
      type: AlertType.success,
      title: message,
      buttons: [],
    ).show();
  }
}
