import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final bool isSearching;
  const ExerciseListTile({
    Key? key,
    required this.exercise,
    required this.isSearching,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.detailExercise,
              arguments: exercise,
            );
          },
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
      secondaryActions: isSearching
          ? null
          : <Widget>[
              IconSlideAction(
                caption: 'Xóa',
                color: Colors.red,
                icon: Icons.delete,
              ),
            ],
    );
  }
}
