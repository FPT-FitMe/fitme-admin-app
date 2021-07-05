import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:fitme_admin_app/widgets/workout_list_tile.dart';
import 'package:flutter/material.dart';

class SearchWorkoutDelegate extends SearchDelegate {
  List<Workout> listWorkouts;

  SearchWorkoutDelegate({required this.listWorkouts});

  @override
  String? get searchFieldLabel => "Nhâp tên khóa tập...";

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
    List<Workout> results = listWorkouts
        .where((workout) =>
            workout.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Khóa tập không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => WorkoutListTile(
        workout: results[index],
        isSearching: true,
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
