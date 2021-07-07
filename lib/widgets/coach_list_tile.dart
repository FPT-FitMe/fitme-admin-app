import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CoachListTile extends StatelessWidget {
  final Coach coach;
  final bool isSearching;
  final Function? onDelete;
  final Function? onRefresh;

  const CoachListTile({
    Key? key,
    required this.coach,
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
            final coachID = await Navigator.pushNamed(
              context,
              AppRoutes.detailCoach,
              arguments: coach,
            );
            if (coachID != null) {
              return onRefresh!();
            }
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(coach.imageUrl),
          ),
          title: Text(coach.name),
          subtitle: Text(coach.contact),
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
              )
            ],
    );
  }
}
