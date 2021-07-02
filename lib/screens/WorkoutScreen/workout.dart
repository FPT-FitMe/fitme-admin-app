import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/SearchWorkoutDelegate/search_workout_delegate.dart';
import 'package:fitme_admin_app/widgets/workout_list_tile.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<Workout> listWorkouts = fakeListWorkouts;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khóa tập"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWorkoutDelegate(
                  listWorkouts: listWorkouts,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailWorkout);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: listWorkouts.length,
        itemBuilder: (context, index) => WorkoutListTile(
          workout: listWorkouts[index],
        ),
      ),
    );
  }
}
