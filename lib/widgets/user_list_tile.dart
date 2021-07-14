import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final bool isSearching;
  final Function? onDelete;
  final Function? onRefresh;
  const UserListTile({
    Key? key,
    required this.user,
    this.onDelete,
    this.onRefresh,
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
            backgroundImage: NetworkImage(user.profileImageUrl != null
                ? user.profileImageUrl.toString()
                : 'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80'),
          ),
          title: Text(user.firstName + " " + user.lastName),
          subtitle: Text('${user.email} - ${user.phone}'),
          onTap: () async {
            final userID = await Navigator.pushNamed(
              context,
              AppRoutes.detailUser,
              arguments: user,
            );
            if (userID != null) {
              return onRefresh!();
            }
          },
        ),
      ),
      secondaryActions: isSearching || user.email == "admin@fitme.vn"
          ? null
          : <Widget>[
              IconSlideAction(
                caption: 'Vô hiệu hóa',
                color: AppColors.red500,
                icon: Icons.delete,
                onTap: () {
                  if (onDelete != null) return onDelete!(user.userID);
                  return null;
                },
              ),
            ],
    );
  }
}
