import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/SearchExerciseDelegate/search_exercise_delegate.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/exercise_presenter.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/exercise_view.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/widgets/exercise_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    implements ExerciseView {
  late ExercisePresenter _presenter;
  bool _isLoading = true;
  List<Exercise> listExercises = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _ExerciseScreenState() {
    _presenter = new ExercisePresenter(this);
    _presenter.loadAllExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bài tập"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchExerciseDelegate(listExercises: listExercises),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailExercise);
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
              child: listExercises.isNotEmpty
                  ? ListView.builder(
                      itemCount: listExercises.length,
                      itemBuilder: (context, index) => ExerciseListTile(
                        isSearching: false,
                        exercise: listExercises[index],
                        onDelete: () {
                          _presenter.deleteExercise(int.parse(
                              listExercises[index].exerciseID.toString()));
                        },
                        onRefresh: refresh,
                      ),
                    )
                  : Center(
                      child: Text("Không có bài tập nào"),
                    ),
            ),
    );
  }

  @override
  void loadExercises(List<Exercise> listExercises) {
    setState(() {
      _isLoading = false;
      this.listExercises = listExercises;
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadAllExercises();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyList() {
    setState(() {
      _isLoading = false;
      listExercises = [];
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
