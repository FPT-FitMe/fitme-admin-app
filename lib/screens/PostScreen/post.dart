import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/screens/PostScreen/SearchPostDelegate/search_post_delegate.dart';
import 'package:fitme_admin_app/widgets/post_list_tile.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Post> listPosts = fakeListPosts;

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
                delegate: SearchPostDelegate(listPosts: listPosts),
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
      body: ListView.builder(
        itemCount: listPosts.length,
        itemBuilder: (context, index) => PostListTile(
          post: listPosts[index],
          isSearching: false,
        ),
      ),
    );
  }
}
