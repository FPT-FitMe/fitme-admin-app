import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  List<Workout> listWorkouts = fakeListWorkouts;
  bool _isLoading = true;

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
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: listWorkouts.length,
        itemBuilder: (context, index) => Slidable(
          key: ValueKey(listWorkouts[index].workoutID),
          actionPane: SlidableDrawerActionPane(),
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  listWorkouts[index].imageUrl != null
                      ? listWorkouts[index].imageUrl.toString()
                      : 'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80',
                ),
              ),
              title: Text(listWorkouts[index].name),
              subtitle: Text(
                  '${listWorkouts[index].estimatedDuration} phút - ${listWorkouts[index].estimatedCalories.toInt()} kcals'),
              trailing: listWorkouts[index].isPremium
                  ? Icon(
                      CommunityMaterialIcons.professional_hexagon,
                      color: AppColors.textColor,
                    )
                  : null,
              onTap: () {},
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: AppColors.red500,
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }
}
