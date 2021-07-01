import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:flutter/material.dart';

class AddExerciseDialog extends StatefulWidget {
  const AddExerciseDialog({Key? key}) : super(key: key);

  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              AppBar(
                title: _isSearching
                    ? TextField(
                        decoration: InputDecoration(
                          hintText: "Nhập tên bài tập...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )
                    : Text(
                        "Tạo mới khóa tập",
                        style: TextStyle(fontSize: 16),
                      ),
                actions: [
                  _isSearching
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearching = false;
                            });
                          },
                          icon: Icon(Icons.close),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                          icon: Icon(Icons.search),
                        )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
              ),
              Expanded(
                child: _createExerciseListTile(),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Tạo mới",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _createExerciseListTile() {
    List<Exercise> _listExercises = fakeListExercises;
    return ListView.builder(
      itemCount: _listExercises.length + 1,
      itemBuilder: (context, index) {
        if (index == _listExercises.length) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.detailWorkout);
            },
            title: Text("Thêm bài tập mới"),
            leading: Icon(Icons.add),
          );
        }
        return CheckboxListTile(
          title: Text(_listExercises[index].name),
          subtitle: Text(_listExercises[index].description),
          controlAffinity: ListTileControlAffinity.trailing,
          secondary: CircleAvatar(
            backgroundImage: NetworkImage(_listExercises[index].imageUrl),
          ),
          onChanged: (bool? value) {
            setState(() {
              _listExercises[index].isChecked = value;
            });
          },
          value: _listExercises[index].isChecked,
        );
      },
    );
  }
}
