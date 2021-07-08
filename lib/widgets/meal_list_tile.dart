import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/screens/MealScreen/DetailMealScreen/detail_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MealListTile extends StatelessWidget {
  final Meal meal;
  final bool isSearching;
  final Function? onDelete;
  final Function? onRefresh;
  const MealListTile({
    Key? key,
    required this.meal,
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
            final mealID = await Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new DetailMealScreen(meal: meal),
              ),
            );
            if (mealID != null) {
              return onRefresh!();
            }
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
