import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:flutter/material.dart';

class AddExerciseDialog extends StatefulWidget {
  final List<Exercise> selectedExercises;
  const AddExerciseDialog({
    Key? key,
    required this.selectedExercises,
  }) : super(key: key);

  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  bool _isSearching = false;
  List<Exercise> allExercises = fakeListExercises;
  List<Exercise> searchResults = fakeListExercises;

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Exercise> selectedExercises = widget.selectedExercises;
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
                        onChanged: (value) {
                          setState(() {
                            searchResults = allExercises
                                .where((element) =>
                                    element.name.toLowerCase().contains(value))
                                .toList();
                          });
                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Nhập tên bài tập...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )
                    : Text(
                        "Thêm bài tập",
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
                child: ListView.builder(
                  itemCount: searchResults.length + 1,
                  itemBuilder: (context, index) {
                    if (index == searchResults.length) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailExercise,
                          );
                        },
                        title: Text("Thêm bài tập mới"),
                        leading: Icon(Icons.add),
                      );
                    }
                    return CheckboxListTile(
                      title: Text(searchResults[index].name),
                      subtitle: Text(searchResults[index].description),
                      controlAffinity: ListTileControlAffinity.trailing,
                      secondary: CircleAvatar(
                        backgroundImage:
                            NetworkImage(searchResults[index].imageUrl),
                      ),
                      onChanged: (bool? value) {
                        if (value == false) {
                          setState(() {
                            selectedExercises.remove(selectedExercises[index]);
                          });
                        } else {
                          setState(() {
                            selectedExercises.add(allExercises[index]);
                          });
                        }
                      },
                      value: selectedExercises
                          .where((element) =>
                              element.name.contains(searchResults[index].name))
                          .isNotEmpty,
                    );
                  },
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selectedExercises);
                  },
                  child: Text(
                    "Thêm vào khóa tập",
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
}
