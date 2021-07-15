import 'package:community_material_icon/community_material_icon.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/DetailWorkoutScreen/detail_workout_presenter.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/DetailWorkoutScreen/detail_workout_view.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailWorkoutScreen extends StatefulWidget {
  final Workout? workout;
  const DetailWorkoutScreen({Key? key, this.workout}) : super(key: key);

  @override
  _DetailWorkoutScreenState createState() => _DetailWorkoutScreenState();
}

class _DetailWorkoutScreenState extends State<DetailWorkoutScreen>
    implements DetailWorkoutView {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Chỉnh sửa bài tập"),
    MenuItem(id: 2, title: "Xóa khóa tập"),
  ];
  bool _isLoading = false;
  bool _isUpdateWorkout = false;
  bool _isPremium = false;
  Coach? selectedCoach;
  bool _isUploadingImage = false;
  late DetailWorkoutPresenter _presenter;
  late Workout? _workout;
  List<Coach> _listCoaches = [];
  int? _workoutID;
  String? _imageUrl;
  Coach? _selectedCoach;
  List<Tag> _selectedTags = [];
  List<WorkoutExercise> _selectedExercises = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _levelController = TextEditingController();
  TextEditingController _estimatedCaloriesController = TextEditingController();
  TextEditingController _estimatedDurationController = TextEditingController();

  _DetailWorkoutScreenState() {
    _presenter = new DetailWorkoutPresenter(this);
    _presenter.loadAllCoaches();
  }

  @override
  void initState() {
    super.initState();
    _workout = widget.workout;
    if (_workout != null) {
      setState(() {
        _isUpdateWorkout = true;
      });
      _workoutID = _workout!.workoutID;
      _isPremium = _workout!.isPremium;
      _nameController.text = _workout!.name;
      _descriptionController.text = _workout!.description;
      _levelController.text = _workout!.level.toString();
      _estimatedCaloriesController.text =
          _workout!.estimatedCalories.toString();
      _estimatedDurationController.text =
          _workout!.estimatedDuration.toString();
      _isPremium = _workout!.isPremium;
      _imageUrl = _workout!.imageUrl;
      _selectedCoach = _workout!.coachProfile;
      _selectedTags = _workout!.tags;
      _selectedExercises = _workout!.workoutExercises;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(_isUpdateWorkout == false ? "Thêm khóa tập" : _workout!.name),
        centerTitle: true,
        actions: [
          if (_isUpdateWorkout)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {
                if (value == "1") {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.workoutExercises,
                    arguments: _workout,
                  );
                } else if (value == "2") {
                  _presenter
                      .deleteWorkout(int.parse(_workout!.workoutID.toString()));
                }
              },
              itemBuilder: (BuildContext context) {
                return menuItems
                    .map((choice) => PopupMenuItem<String>(
                          value: choice.id.toString(),
                          child: Text(
                            choice.title,
                            style: TextStyle(
                              color: choice.id.toString() == "2"
                                  ? AppColors.red500
                                  : null,
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
                child: GestureDetector(
                  onTap: () {
                    _showImagePicker();
                  },
                  child: CircleAvatar(
                    radius: 40,
                    child: _imageUrl != null
                        ? null
                        : _isUploadingImage
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : Icon(Icons.add_a_photo),
                    backgroundImage: _imageUrl != null
                        ? NetworkImage(_imageUrl.toString())
                        : null,
                  ),
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
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Bắt buộc"),
                          MaxLengthValidator(255,
                              errorText: "Tối đa 255 ký tự"),
                        ],
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
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Bắt buộc"),
                          MaxLengthValidator(255,
                              errorText: "Tối đa 255 ký tự"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _levelController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Cấp độ bài tập",
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Bắt buộc"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _isUpdateWorkout
                        ? Column(
                            children: [
                              TextFormField(
                                controller: _estimatedCaloriesController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: "Calories bài tập",
                                  suffixText: "cals",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _estimatedDurationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixText: "phút",
                                  labelText: "Thời lượng bài tập",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : Container(),
                    if (_listCoaches.isNotEmpty)
                      DropdownSearch<Coach>(
                        mode: Mode.BOTTOM_SHEET,
                        label: "Huấn luyện viên viết bài",
                        items: _listCoaches,
                        onChanged: (coach) => {
                          setState(() {
                            _selectedCoach = coach!;
                          })
                        },
                        itemAsString: (coach) => coach.name,
                        dropdownBuilder:
                            (context, selectedItem, itemAsString) => ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(selectedItem!.imageUrl),
                            radius: 18,
                          ),
                          title: Text(selectedItem.name),
                        ),
                        popupItemBuilder: (context, coach, isSelected) =>
                            CoachListTile(
                          coach: coach,
                          isSearching: true,
                        ),
                        showSearchBox: true,
                        selectedItem: _selectedCoach == null
                            ? _listCoaches[0]
                            : _selectedCoach,
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
                          _isPremium = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MultiSelectChipDisplay(
                      items: _selectedTags
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
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
            onPressed: () {
              _submitForm();
            },
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

  void _showImagePicker() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _isUploadingImage = true;
      });
      _presenter.uploadImage(image.path);
      _isLoading = true;
    }
  }

  void _submitForm() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    int level = int.parse(_levelController.text);
    int? estimatedCalories = int.tryParse(_estimatedCaloriesController.text);
    int? estimatedDuration = int.tryParse(_estimatedDurationController.text);
    if (_formKey.currentState!.validate() && _isLoading == false) {
      setState(() {
        _isLoading = true;
      });
      Workout workout = Workout(
        workoutID: _workoutID,
        name: name,
        description: description,
        level: level,
        coachProfile: _selectedCoach,
        estimatedCalories: estimatedCalories,
        estimatedDuration: estimatedDuration,
        imageUrl: _imageUrl.toString(),
        isPremium: _isPremium,
        tags: _selectedTags,
        workoutExercises: _selectedExercises,
      );
      if (!_isUpdateWorkout)
        _presenter.addWorkout(workout);
      else
        _presenter.updateWorkout(workout);
    }
  }

  @override
  void backToWorkoutScreen(int? deletedMealID) {
    Navigator.pop(context, deletedMealID);
  }

  @override
  void loadCoaches(List<Coach> listCoaches) {
    setState(() {
      this._listCoaches = listCoaches;
      _isLoading = false;
      if (_selectedCoach == null) this._selectedCoach = listCoaches[0];
    });
  }

  @override
  void showFailedModal(String message) {
    setState(() {
      _isLoading = false;
      _isUploadingImage = false;
    });
    Alert(
      context: context,
      type: AlertType.error,
      title: message,
      buttons: [],
    ).show();
  }

  @override
  void showSuccessModal(Workout workout, String message) {
    setState(() {
      _isLoading = false;
      _isUploadingImage = false;
    });
    Alert(
      context: context,
      type: AlertType.success,
      title: message,
      buttons: [],
    ).show();
  }

  @override
  void updateImageUrl(String? imageUrl) {
    setState(() {
      _isUploadingImage = false;
      _imageUrl = imageUrl;
      _isLoading = false;
    });
  }
}
