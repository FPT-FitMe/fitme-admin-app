import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/screens/CoachScreen/SearchCoachDelegate/search_coach_delegate.dart';
import 'package:fitme_admin_app/screens/CoachScreen/coach_presenter.dart';
import 'package:fitme_admin_app/screens/CoachScreen/coach_view.dart';
import 'package:fitme_admin_app/screens/LoadingScreen/loading.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({Key? key}) : super(key: key);

  @override
  _CoachScreenState createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> implements CoachView {
  late CoachPresenter _presenter;
  bool _isLoading = true;
  List<Coach> listCoaches = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _CoachScreenState() {
    _presenter = new CoachPresenter(this);
    _presenter.loadAllCoaches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Huấn luyện viên"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchCoachDelegate(listCoaches: this.listCoaches),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.detailCoach);
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
              child: ListView.builder(
                itemCount: listCoaches.length,
                itemBuilder: (context, index) => CoachListTile(
                  isSearching: false,
                  coach: listCoaches[index],
                  onDelete: _tapToDelete,
                  onRefresh: refresh,
                ),
              ),
            ),
    );
  }

  void _tapToDelete(int deleteCoachID) {
    _presenter.deleteCoach(deleteCoachID);
  }

  @override
  void loadCoaches(List<Coach> listCoaches) {
    setState(() {
      _isLoading = false;
      this.listCoaches = listCoaches;
    });
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
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void refresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadAllCoaches();
    _refreshController.refreshCompleted();
  }
}
