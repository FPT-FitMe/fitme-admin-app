import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/widgets/exercise_list_tile.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Exercise> listExercises = fakeListExercises;

    return Scaffold(
      appBar: AppBar(
        title: Text("Bài tập"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: listExercises.length,
        itemBuilder: (context, index) => ExerciseListTile(
          exercise: listExercises[index],
        ),
      ),
    );
  }
}
