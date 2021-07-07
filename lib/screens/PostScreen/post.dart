import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/PostScreen/SearchPostDelegate/search_post_delegate.dart';
import 'package:fitme_admin_app/screens/PostScreen/post_presenter.dart';
import 'package:fitme_admin_app/screens/PostScreen/post_view.dart';
import 'package:fitme_admin_app/widgets/post_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> implements PostView {
  late PostPresenter _presenter;
  bool _isLoading = true;
  List<Post> _listPosts = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _PostScreenState() {
    _presenter = new PostPresenter(this);
    _presenter.loadAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài viết"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPostDelegate(listPosts: _listPosts),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailPost);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? LoadingScreen()
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: refresh,
              child: _listPosts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _listPosts.length,
                      itemBuilder: (context, index) => PostListTile(
                        post: _listPosts[index],
                        isSearching: false,
                        onDelete: () {
                          _presenter.deletePost(
                              int.parse(_listPosts[index].postID.toString()));
                        },
                        onRefresh: refresh,
                      ),
                    )
                  : Center(
                      child: Text("Không có bài viết nào"),
                    ),
            ),
    );
  }

  @override
  void loadPosts(List<Post> listPosts) {
    setState(() {
      _isLoading = false;
      this._listPosts = listPosts;
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
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadAllPosts();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyList() {
    setState(() {
      _isLoading = false;
      _listPosts = [];
    });
    _refreshController.refreshCompleted();
  }
}
