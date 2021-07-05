import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:fitme_admin_app/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';

class SearchUserDelegate extends SearchDelegate {
  List<User> listUsers;

  SearchUserDelegate({required this.listUsers});

  @override
  String? get searchFieldLabel => "Nhập tên người dùng...";

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
    List<User> results = listUsers
        .where((user) => user.email.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Người dùng không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => UserListTile(
        isSearching: true,
        user: results[index],
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
