import 'package:fitme_admin_app/models/coach.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CoachListTile extends StatelessWidget {
  final Coach coach;

  const CoachListTile({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(coach.imageUrl),
          ),
          title: Text(coach.name),
          subtitle: Text(coach.contact),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Xóa',
          color: Colors.red,
          icon: Icons.delete,
        )
      ],
    );
  }
}
