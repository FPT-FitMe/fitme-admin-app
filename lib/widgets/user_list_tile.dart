import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final bool isSearching;
  const UserListTile({
    Key? key,
    required this.user,
    this.isSearching = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl != null
                ? user.imageUrl.toString()
                : 'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80'),
          ),
          title: Text(user.username),
          subtitle: Text('${user.email} - ${user.phone}'),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.detailUser, arguments: user);
          },
        ),
      ),
      secondaryActions: isSearching
          ? null
          : <Widget>[
              IconSlideAction(
                caption: 'Xóa',
                color: AppColors.red500,
                icon: Icons.delete,
              ),
            ],
    );
  }
}
