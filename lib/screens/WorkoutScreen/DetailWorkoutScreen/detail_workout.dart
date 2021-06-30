import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:flutter/material.dart';

class DetailWorkoutScreen extends StatefulWidget {
  const DetailWorkoutScreen({Key? key}) : super(key: key);

  @override
  _DetailWorkoutScreenState createState() => _DetailWorkoutScreenState();
}

class _DetailWorkoutScreenState extends State<DetailWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> menuItems = ["Xóa khóa tập"];
  bool _isLoading = false;
  bool _isUpdateWorkout = false;
  int _coachID = fakeListCoaches.first.coachID;
  bool? _isPremium = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _estimatedCaloriesController = TextEditingController();
  TextEditingController _estimatedDurationController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _levelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Workout? workout =
        ModalRoute.of(context)!.settings.arguments as Workout?;
    if (workout != null) {
      setState(() {
        _isUpdateWorkout = true;
      });
      _nameController.text = workout.name;
      _descriptionController.text = workout.description;
      _estimatedCaloriesController.text = workout.estimatedCalories.toString();
      _estimatedDurationController.text = workout.estimatedDuration.toString();
      _imageUrlController.text = workout.imageUrl;
      _levelController.text = workout.level.toString();
      _isPremium = workout.isPremium;
      _coachID = fakeListCoaches
          .firstWhere((coach) => coach.coachID == workout.coach.coachID)
          .coachID;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(_isUpdateWorkout == false ? "Thêm khóa tập" : workout!.name),
        centerTitle: true,
        actions: [
          if (_isUpdateWorkout)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return menuItems
                    .map((choice) => PopupMenuItem<String>(
                          value: "1",
                          child: Text(
                            choice,
                            style: TextStyle(
                              color: AppColors.red500,
                            ),
                          ),
                        ))
                    .toList();
              },
            )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: workout != null ? null : Icon(Icons.add_a_photo),
                  backgroundImage: workout != null
                      ? NetworkImage(workout.imageUrl.toString())
                      : null,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Tên khóa tập",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Mô tả khóa tập",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _estimatedCaloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Calories",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _estimatedDurationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Thời lượng",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: "URL hình ảnh",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _levelController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Cấp loại",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: DropdownButtonFormField(
                        value: _coachID,
                        items: fakeListCoaches
                            .map(
                              (coach) => DropdownMenuItem(
                                value: coach.coachID,
                                child: Text(coach.name),
                              ),
                            )
                            .toList(),
                        onChanged: (coachID) {
                          setState(() {
                            this._coachID = int.parse(coachID.toString());
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          labelText: "Huấn luyện viên",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CheckboxListTile(
                      secondary: Icon(
                        CommunityMaterialIcons.professional_hexagon,
                      ),
                      title: Align(
                        child: Text("Nội dung trả tiền"),
                        alignment: Alignment(-1.2, 0),
                      ),
                      value: _isPremium,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPremium = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Text(
                    _isUpdateWorkout ? "Cập nhật khóa tập" : "Tạo khóa tập mới",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }
}
