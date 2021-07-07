import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/screens/CoachScreen/DetailCoachScreen/detail_coach_presenter.dart';
import 'package:fitme_admin_app/screens/CoachScreen/DetailCoachScreen/detail_coach_view.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailCoachScreen extends StatefulWidget {
  const DetailCoachScreen({Key? key}) : super(key: key);

  @override
  _DetailCoachScreenState createState() => _DetailCoachScreenState();
}

class _DetailCoachScreenState extends State<DetailCoachScreen>
    implements DetailCoachView {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa huấn luyện viên"),
  ];
  bool _isLoading = false;
  bool _isUploadingImage = false;
  bool _isUpdateCoach = false;
  late DetailCoachPresenter _presenter;
  late Coach? _coach;
  int? _coachID;
  String? _imageUrl;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  _DetailCoachScreenState() {
    _presenter = new DetailCoachPresenter(this);
  }

  @override
  void didChangeDependencies() {
    _coach = ModalRoute.of(context)!.settings.arguments as Coach?;
    if (_coach != null) {
      setState(() {
        _isUpdateCoach = true;
      });
      _coachID = _coach!.coachID;
      _nameController.text = _coach!.name;
      _introductionController.text = _coach!.introduction;
      _contactController.text = _coach!.contact.toString();
      _imageUrl = _coach!.imageUrl;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateCoach == false ? "Thêm huấn luyện viên" : _coach!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdateCoach)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {
                if (value == "1") {
                  _presenter.deleteCoach(int.parse(_coach!.coachID.toString()));
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
                        labelText: "Tên huấn luyện viên",
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
                      controller: _introductionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Lời giới thiệu",
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
                      controller: _contactController,
                      decoration: InputDecoration(
                        labelText: "Liên hệ",
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
                    _isUpdateCoach
                        ? "Cập nhật huấn luyện viên"
                        : "Tạo huấn luyện viên mới",
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

  @override
  void showSuccessModal(Coach coach, String message) {
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
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  void _showImagePicker() async {
    PickedFile? image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _isUploadingImage = true;
      });
      _presenter.uploadImage(image.path);
    }
  }

  void _submitForm() {
    String name = _nameController.text;
    String contact = _contactController.text;
    String introduction = _introductionController.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Coach coach = Coach(
        coachID: _coachID,
        name: name,
        contact: contact,
        introduction: introduction,
        imageUrl: _imageUrl != null
            ? _imageUrl.toString()
            : "https://miro.medium.com/max/720/1*W35QUSvGpcLuxPo3SRTH4w.png",
      );
      if (!_isUpdateCoach)
        _presenter.addCoach(coach);
      else
        _presenter.updateCoach(coach);
    }
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
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void updateImageUrl(String? imageUrl) {
    setState(() {
      _isUploadingImage = false;
      _imageUrl = imageUrl;
    });
  }

  @override
  void backToCoachScreen(int? deletedCoachID) {
    Navigator.pop(context, deletedCoachID);
  }
}
