import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/DetailExerciseScreen/detail_exercise_presenter.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/DetailExerciseScreen/detail_exercise_view.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailExerciseScreen extends StatefulWidget {
  final Exercise? exercise;
  const DetailExerciseScreen({Key? key, this.exercise}) : super(key: key);

  @override
  _DetailExerciseScreenState createState() => _DetailExerciseScreenState();
}

class _DetailExerciseScreenState extends State<DetailExerciseScreen>
    implements DetailExerciseView {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa bài tập"),
  ];
  bool _isUpdateExercise = false;
  bool _isUploadingImage = false;
  bool _isUploadingGif = false;
  late DetailExercisePresenter _presenter;
  late Exercise? _exercise;
  List<Tag> _listTags = [];
  int? _exerciseID;
  String? _imageUrl;
  String? _videoUrl;
  List<Tag> _selectedTags = [];
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _baseRepController = TextEditingController();
  TextEditingController _baseDurationController = TextEditingController();
  TextEditingController _baseKcalController = TextEditingController();

  _DetailExerciseScreenState() {
    _presenter = new DetailExercisePresenter(this);
    _presenter.loadMealTags();
  }

  @override
  void initState() {
    super.initState();
    _exercise = widget.exercise;
    if (_exercise != null) {
      setState(() {
        _isUpdateExercise = true;
      });
      _exerciseID = _exercise!.exerciseID;
      _nameController.text = _exercise!.name;
      _descriptionController.text = _exercise!.description;
      _baseKcalController.text = _exercise!.baseKcal.toString();
      _baseRepController.text = _exercise!.baseRepPerRound.toString();
      _baseDurationController.text = _exercise!.baseDuration.toString();
      _imageUrl = _exercise!.imageUrl;
      _videoUrl = _exercise!.videoUrl;
      _selectedTags = _exercise!.tags;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateExercise == false ? "Thêm bài tập" : _exercise!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdateExercise)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {
                if (value == "1") {
                  _presenter.deleteExercise(
                      int.parse(_exercise!.exerciseID.toString()));
                }
              },
              itemBuilder: (BuildContext context) {
                return menuItems
                    .map((choice) => PopupMenuItem<String>(
                          value: choice.id.toString(),
                          child: Text(
                            choice.title,
                            style: TextStyle(
                              color: choice.id.toString() == "1"
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
                        labelText: "Tên bài tập",
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
                        labelText: "Mô tả",
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
                      controller: _baseRepController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Số reps",
                        suffixText: "reps",
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
                    TextFormField(
                      controller: _baseDurationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Thời lượng bài tập",
                        suffixText: "phút",
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
                    TextFormField(
                      controller: _baseKcalController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng calo",
                        suffixText: "cals",
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
                    MultiSelectDialogField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phải có tối thiểu 1 tag';
                        }
                        return null;
                      },
                      items: _listTags
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        _selectedTags = values.toList().cast<Tag>();
                      },
                      initialValue: _selectedTags,
                      chipDisplay: MultiSelectChipDisplay(),
                      title: Text("Tag bài tập"),
                      cancelText: Text("Hủy bỏ"),
                      confirmText: Text("Xác nhận"),
                      buttonText: Text("Tag bài tập"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Gif bài tập"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showGifPicker();
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _videoUrl != null
                            ? Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  image: DecorationImage(
                                    image: NetworkImage(_videoUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                color: Colors.black12,
                                child: Center(
                                  child: _isUploadingGif
                                      ? CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        )
                                      : Icon(Icons.add_a_photo),
                                ),
                              ),
                      ),
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
                    _isUpdateExercise ? "Cập nhật bài tập" : "Tạo bài tập mới",
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
      _presenter.uploadImage(image.path, false);
      _isLoading = true;
    }
  }

  void _showGifPicker() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _isUploadingGif = true;
      });
      _presenter.uploadImage(image.path, true);
      _isLoading = true;
    }
  }

  void _submitForm() async {
    String name = _nameController.text;
    String description = _descriptionController.text;
    int baseRep = int.parse(_baseRepController.text);
    int baseDuration = int.parse(_baseDurationController.text);
    int baseKcal = int.parse(_baseKcalController.text);
    if (_formKey.currentState!.validate() && _isLoading == false) {
      setState(() {
        _isLoading = true;
      });
      Exercise exercise = Exercise(
        exerciseID: _exerciseID,
        name: name,
        description: description,
        baseRepPerRound: baseRep,
        baseKcal: baseKcal,
        baseDuration: baseDuration,
        imageUrl: _imageUrl.toString(),
        videoUrl: _videoUrl.toString(),
        tags: _selectedTags,
      );

      if (!_isUpdateExercise)
        _presenter.addExercise(exercise);
      else
        _presenter.updateExercise(exercise);
    }
  }

  @override
  void backToExerciseScreen(int? deletedExerciseID) {
    Navigator.pop(context, deletedExerciseID);
  }

  @override
  void loadTags(List<Tag> listTags) {
    setState(() {
      this._listTags = listTags;
      _isLoading = false;
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
  void showSuccessModal(Exercise exercise, String message) {
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

  @override
  void updateVideoUrl(String? videoUrl) {
    setState(() {
      _isUploadingGif = false;
      _videoUrl = videoUrl;
      _isLoading = false;
    });
  }
}
