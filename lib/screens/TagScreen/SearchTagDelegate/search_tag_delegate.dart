import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/TagScreen/DetailTagDialog/detail_tag_dialog.dart';
import 'package:fitme_admin_app/widgets/no_data_view.dart';
import 'package:flutter/material.dart';

class SearchTagDelegate extends SearchDelegate {
  List<Tag> listTags;

  SearchTagDelegate({required this.listTags});

  @override
  String? get searchFieldLabel => "Nhâp tên tag...";

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
    List<Tag> results = listTags
        .where((tag) => tag.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0)
      return NoDataView(
        title: "Tag không tồn tại",
      );
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DetailTagDialog(),
            routeSettings: RouteSettings(arguments: results[index]),
          );
        },
        title: Text(results[index].name),
        leading: results[index].type == TagTypes.exercise
            ? Icon(CommunityMaterialIcons.arm_flex)
            : Icon(CommunityMaterialIcons.pot_steam),
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
