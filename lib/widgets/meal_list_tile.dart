import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  final bool isSearching;
  const MealListTile({Key? key, required this.meal, this.isSearching = false})
      : super(key: key);

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
              AppRoutes.detailMeal,
              arguments: meal,
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(meal.imageUrl),
          ),
          title: Text(meal.name),
          subtitle:
              Text("${meal.cookingTime} phút - ${meal.calories.toInt()} cals"),
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
