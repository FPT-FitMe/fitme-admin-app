import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/TagScreen/DetailTagDialog/detail_tag_dialog.dart';
import 'package:fitme_admin_app/screens/TagScreen/SearchTagDelegate/search_tag_delegate.dart';
import 'package:fitme_admin_app/screens/TagScreen/tag_presenter.dart';
import 'package:fitme_admin_app/screens/TagScreen/tag_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TagScreen extends StatefulWidget {
  const TagScreen({Key? key}) : super(key: key);

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> implements TagView {
  late TagPresenter _presenter;
  bool _isLoading = true;
  List<Tag> _listMealTags = [];
  List<Tag> _listExerciseTags = [];
  RefreshController _mealRefreshController =
      RefreshController(initialRefresh: false);
  RefreshController _exerciseRefreshController =
      RefreshController(initialRefresh: false);

  _TagScreenState() {
    _presenter = new TagPresenter(this);
    _presenter.loadAllTags();
  }

  @override
  Widget build(BuildContext context) {
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
                      listTags: _listMealTags + _listExerciseTags),
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
              builder: (context) => DetailTagDialog(
                onRefresh: _presenter.loadTagsByType,
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primary,
        ),
        body: _isLoading
            ? LoadingScreen()
            : TabBarView(
                children: [
                  SmartRefresher(
                    controller: _mealRefreshController,
                    onRefresh: () => _presenter.loadTagsByType(TagTypes.meal),
                    child: ListView.builder(
                      itemCount: _listMealTags.length,
                      itemBuilder: (context, index) => Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DetailTagDialog(
                                  onRefresh: _presenter.loadTagsByType,
                                ),
                                routeSettings: RouteSettings(
                                    arguments: _listMealTags[index]),
                              );
                            },
                            title: Text(_listMealTags[index].name),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () =>
                                  _presenter.deleteTag(_listMealTags[index])),
                        ],
                      ),
                    ),
                  ),
                  SmartRefresher(
                    controller: _exerciseRefreshController,
                    onRefresh: () =>
                        _presenter.loadTagsByType(TagTypes.exercise),
                    child: ListView.builder(
                      itemCount: _listExerciseTags.length,
                      itemBuilder: (context, index) => Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => DetailTagDialog(
                                  onRefresh: _presenter.loadTagsByType,
                                ),
                                routeSettings: RouteSettings(
                                    arguments: _listExerciseTags[index]),
                              );
                            },
                            title: Text(_listExerciseTags[index].name),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () =>
                                _presenter.deleteTag(_listExerciseTags[index]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void loadTags(List<Tag> listTags) {
    setState(() {
      _listMealTags =
          listTags.where((tag) => tag.type == TagTypes.meal).toList();
      _listExerciseTags =
          listTags.where((tag) => tag.type == TagTypes.exercise).toList();
      _isLoading = false;
    });
  }

  @override
  void showFailedModal(String message) {
    setState(() {
      _isLoading = false;
    });
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      buttons: [],
    ).show();
  }

  @override
  void refreshTypeView(String type, List<Tag> listTags) {
    setState(() {
      _isLoading = false;
      if (type == TagTypes.meal) {
        _listMealTags = listTags;
        _mealRefreshController.refreshCompleted();
      } else {
        _listExerciseTags = listTags;
        _exerciseRefreshController.refreshCompleted();
      }
    });
  }

  @override
  void deleteTag(Tag tag) {
    setState(() {
      _isLoading = false;
      if (tag.type == TagTypes.meal) {
        _listMealTags.removeWhere((mealTag) => mealTag.id == tag.id);
        _mealRefreshController.refreshCompleted();
      } else {
        _listExerciseTags
            .removeWhere((exerciseTag) => exerciseTag.id == tag.id);
        _exerciseRefreshController.refreshCompleted();
      }
    });
  }
}
