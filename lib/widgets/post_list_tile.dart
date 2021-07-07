import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PostListTile extends StatelessWidget {
  final Post post;
  final bool isSearching;
  final Function? onDelete;
  final Function? onRefresh;
  const PostListTile({
    Key? key,
    required this.post,
    this.isSearching = false,
    this.onDelete,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          onTap: () async {
            final postID = await Navigator.pushNamed(
              context,
              AppRoutes.detailPost,
              arguments: post,
            );
            if (postID != null) {
              return onRefresh!();
            }
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(post.imageUrl),
          ),
          title: Text(post.name),
          subtitle: Text("${post.readingTime} phút đọc"),
        ),
      ),
      secondaryActions: isSearching
          ? null
          : <Widget>[
              IconSlideAction(
                onTap: () {
                  if (onDelete != null) return onDelete!();
                  return null;
                },
                caption: 'Xóa',
                color: Colors.red,
                icon: Icons.delete,
              ),
            ],
    );
  }
}
