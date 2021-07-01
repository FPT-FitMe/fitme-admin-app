import 'package:fitme_admin_app/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  const MealListTile({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(meal.imageUrl),
          ),
          title: Text(meal.name),
          subtitle:
              Text("${meal.cookingTime} phút - ${meal.calories.toInt()} cals"),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Xóa',
          color: Colors.red,
          icon: Icons.delete,
        ),
      ],
    );
  }
}
