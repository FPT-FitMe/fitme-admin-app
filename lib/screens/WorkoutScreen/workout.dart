import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/SearchWorkoutDelegate/search_workout_delegate.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/workout_presenter.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/workout_view.dart';
import 'package:fitme_admin_app/widgets/workout_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> implements WorkoutView {
  late WorkoutPresenter _presenter;
  List<Workout> _listWorkouts = [];
  bool _isLoading = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _WorkoutScreenState() {
    _presenter = new WorkoutPresenter(this);
    _presenter.loadAllWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khóa tập"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWorkoutDelegate(
                  listWorkouts: _listWorkouts,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailWorkout);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: _isLoading == true
          ? LoadingScreen()
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: refresh,
              child: _listWorkouts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _listWorkouts.length,
                      itemBuilder: (context, index) => WorkoutListTile(
                        isSearching: false,
                        workout: _listWorkouts[index],
                        onDelete: () {
                          _presenter.deleteWorkout(int.parse(
                              _listWorkouts[index].workoutID.toString()));
                        },
                        onRefresh: refresh,
                      ),
                    )
                  : Center(
                      child: Text("Không có khóa tập nào"),
                    ),
            ),
    );
  }

  @override
  void loadWorkouts(List<Workout> listWorkouts) {
    setState(() {
      _isLoading = false;
      this._listWorkouts = listWorkouts;
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadAllWorkouts();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyList() {
    setState(() {
      _isLoading = false;
      _listWorkouts = [];
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
