import 'package:fitme_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tags = List<String>.generate(10, (i) => 'Item $i');

    return Scaffold(
      appBar: AppBar(
        title: Text("Bài tập"),
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
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) => Slidable(
          actionPane: SlidableDrawerActionPane(),
          child: Container(
            color: Colors.white,
            child: ListTile(
              title: Text(tags[index]),
            ),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }
}
