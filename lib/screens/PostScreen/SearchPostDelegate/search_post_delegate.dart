import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:fitme_admin_app/widgets/post_list_tile.dart';
import 'package:flutter/material.dart';

class SearchPostDelegate extends SearchDelegate {
  List<Post> listPosts;

  SearchPostDelegate({required this.listPosts});

  @override
  String? get searchFieldLabel => "Nhâp tên bài viết...";

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
    List<Post> results = listPosts
        .where((post) => post.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Bài viết không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => PostListTile(
        isSearching: true,
        post: results[index],
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
