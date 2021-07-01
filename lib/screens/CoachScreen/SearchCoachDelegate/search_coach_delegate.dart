import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:flutter/material.dart';

class SearchCoachDelegate extends SearchDelegate {
  List<Coach> listCoaches;

  SearchCoachDelegate({required this.listCoaches});

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
    List<Coach> results = listCoaches
        .where((coach) =>
            coach.name.toLowerCase().contains(query.toLowerCase()) ||
            coach.contact.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Người dùng không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => CoachListTile(
        isSearching: true,
        coach: results[index],
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
