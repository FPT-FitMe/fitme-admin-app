import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/widgets/exercise_list_tile.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:flutter/material.dart';

class SearchExerciseDelegate extends SearchDelegate {
  List<Exercise> listExercises;

  SearchExerciseDelegate({required this.listExercises});

  @override
  String? get searchFieldLabel => "Nhâp tên huấn luyện viên...";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Exercise> results = listExercises
        .where((exercise) =>
            exercise.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Bài tập không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ExerciseListTile(
        isSearching: true,
        exercise: results[index],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}
