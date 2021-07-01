import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/AddExerciseDialog/add_workout_dialog.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:flutter/material.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  const WorkoutExerciseScreen({Key? key}) : super(key: key);

  @override
  _WorkoutExerciseScreenState createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final Workout workout =
        ModalRoute.of(context)!.settings.arguments as Workout;
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddExerciseDialog(),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: workout.exercises.isNotEmpty
          ? ReorderableListView.builder(
              itemBuilder: (context, index) =>
                  _createReorderableExercise(workout.exercises[index]),
              itemCount: workout.exercises.length,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Exercise item = workout.exercises.removeAt(oldIndex);
                  workout.exercises.insert(newIndex, item);
                });
              },
            )
          : NoDataView(
              title: "Hiện tại chưa có bài tập nào",
            ),
    );
  }

  Widget _createReorderableExercise(Exercise exercise) {
    return ListTile(
      key: Key(exercise.exerciseID.toString()),
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
}
