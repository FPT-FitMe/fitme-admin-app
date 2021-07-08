import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/DetailExerciseScreen/detail_excercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseListTile extends StatelessWidget {
  final Exercise exercise;
  final bool isSearching;
  final Function? onDelete;
  final Function? onRefresh;
  const ExerciseListTile({
    Key? key,
    required this.exercise,
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
            final exerciseID = await Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                    new DetailExerciseScreen(exercise: exercise),
              ),
            );
            if (exerciseID != null) {
              return onRefresh!();
            }
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
