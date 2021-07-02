import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/screens/MealScreen/SearchMealDelegate/search_meal_delegate.dart';
import 'package:fitme_admin_app/widgets/meal_list_tile.dart';
import 'package:flutter/material.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Meal> listMeals = fakeListMeals;

    return Scaffold(
      appBar: AppBar(
        title: Text("Món ăn"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchMealDelegate(listMeals: listMeals),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailMeal);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: listMeals.length,
        itemBuilder: (context, index) => MealListTile(meal: listMeals[index]),
      ),
    );
  }
}
