import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/TagScreen/DetailTagDialog/detail_tag_dialog.dart';
import 'package:fitme_admin_app/screens/TagScreen/SearchTagDelegate/search_tag_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TagScreen extends StatelessWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Tag> listMealTags = fakeListMealTags;
    final List<Tag> listExerciseTags = fakeListExerciseTags;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tags"),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchTagDelegate(
                      listTags: listMealTags + listExerciseTags),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Món ăn",
              ),
              Tab(
                text: "Bài tập",
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DetailTagDialog(),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primary,
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: listMealTags.length,
              itemBuilder: (context, index) => Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DetailTagDialog(),
                        routeSettings:
                            RouteSettings(arguments: listMealTags[index]),
                      );
                    },
                    title: Text(listMealTags[index].name),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: listExerciseTags.length,
              itemBuilder: (context, index) => Slidable(
                actionPane: SlidableDrawerActionPane(),
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DetailTagDialog(),
                        routeSettings:
                            RouteSettings(arguments: listExerciseTags[index]),
                      );
                    },
                    title: Text(listExerciseTags[index].name),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
