import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkoutListTile extends StatelessWidget {
  final Workout workout;
  const WorkoutListTile({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(workout.workoutID),
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(workout.imageUrl),
          ),
          title: Text(workout.name),
          subtitle: Text(
              '${workout.estimatedDuration} phút - ${workout.estimatedCalories.toInt()} cals'),
          trailing: workout.isPremium
              ? Icon(
                  CommunityMaterialIcons.professional_hexagon,
                  color: AppColors.textColor,
                )
              : null,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.detailWorkout,
              arguments: workout,
            );
          },
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Bài tập',
          color: Colors.blue[500],
          icon: CommunityMaterialIcons.playlist_edit,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.workoutExercises,
              arguments: workout,
            );
          },
        ),
        IconSlideAction(
          caption: 'Xóa',
          color: AppColors.red500,
          icon: Icons.delete,
        ),
      ],
    );
  }
}
