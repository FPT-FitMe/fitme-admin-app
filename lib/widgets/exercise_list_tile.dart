import 'package:fitme_admin_app/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseListTile({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              exercise.imageUrl,
            ),
          ),
          title: Text(exercise.name),
          subtitle: Text(
              "${exercise.baseDuration} phút - ${exercise.baseRepPerRound} reps"),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
        ),
      ],
    );
  }
}
