import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/screens/CoachScreen/SearchCoachDelegate/search_coach_delegate.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:flutter/material.dart';

class CoachScreen extends StatelessWidget {
  const CoachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Coach> listCoaches = fakeListCoaches;

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
                delegate: SearchCoachDelegate(listCoaches: listCoaches),
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
      body: ListView.builder(
        itemCount: listCoaches.length,
        itemBuilder: (context, index) => CoachListTile(
          isSearching: false,
          coach: listCoaches[index],
        ),
      ),
    );
  }
}
