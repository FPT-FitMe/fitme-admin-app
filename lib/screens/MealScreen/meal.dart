import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/MealScreen/SearchMealDelegate/search_meal_delegate.dart';
import 'package:fitme_admin_app/screens/MealScreen/meal_presenter.dart';
import 'package:fitme_admin_app/screens/MealScreen/meal_view.dart';
import 'package:fitme_admin_app/widgets/meal_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> implements MealView {
  late MealPresenter _presenter;
  bool _isLoading = true;
  List<Meal> listMeals = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _MealScreenState() {
    _presenter = new MealPresenter(this);
    _presenter.loadAllMeals();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading == true
          ? LoadingScreen()
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: refresh,
              child: listMeals.isNotEmpty
                  ? ListView.builder(
                      itemCount: listMeals.length,
                      itemBuilder: (context, index) => MealListTile(
                        isSearching: false,
                        meal: listMeals[index],
                        onDelete: () {
                          _presenter.deleteMeal(
                              int.parse(listMeals[index].mealID.toString()));
                        },
                        onRefresh: refresh,
                      ),
                    )
                  : Center(
                      child: Text("Không có món ăn nào"),
                    ),
            ),
    );
  }

  @override
  void loadMeals(List<Meal> listMeals) {
    setState(() {
      _isLoading = false;
      this.listMeals = listMeals;
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadAllMeals();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyList() {
    setState(() {
      _isLoading = false;
      listMeals = [];
    });
    _refreshController.refreshCompleted();
  }

  @override
  void showFailedModal(String message) {
    setState(() {
      _isLoading = false;
    });
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      buttons: [],
    ).show();
  }
}
