import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/fake_data.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/screens/PostScreen/DetailPostScreen/detail_post_view.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'detail_post_presenter.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({Key? key}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen>
    implements DetailPostView {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa bài viết"),
  ];
  bool _isLoading = true;
  bool _isUpdatePost = false;
  Coach? selectedCoach;
  bool _isUploadingImage = false;
  late DetailPostPresenter _presenter;
  late Post? _post;
  List<Coach> _listCoaches = [];
  int? _postID;
  String? _imageUrl;
  Coach? _selectedCoach;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contentBodyController = TextEditingController();
  TextEditingController _contentHeaderController = TextEditingController();
  TextEditingController _readingTimeController = TextEditingController();

  _DetailPostScreenState() {
    _presenter = new DetailPostPresenter(this);
    _presenter.loadAllCoaches();
  }

  @override
  void didChangeDependencies() {
    _post = ModalRoute.of(context)!.settings.arguments as Post?;
    if (_post != null) {
      setState(() {
        _isUpdatePost = true;
      });
      _postID = _post!.postID;
      _nameController.text = _post!.name;
      _contentBodyController.text = _post!.contentBody;
      _contentHeaderController.text = _post!.contentHeader;
      _readingTimeController.text = _post!.readingTime.toString();
      _imageUrl = _post!.imageUrl;
      _selectedCoach = _post!.coachProfile;
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
          _isUpdatePost == false ? "Thêm bài viết" : _post!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdatePost)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {
                if (value == "1") {
                  _presenter.deletePost(int.parse(_post!.postID.toString()));
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
                        labelText: "Tên bài viết",
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
                      controller: _contentHeaderController,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Tiêu đề nội dung",
                      ),
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "* Bắt buộc"),
                          MaxLengthValidator(255,
                              errorText: "Tối đa 255 ký tự"),
                        ],
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _contentBodyController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Nội dung",
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
                      controller: _readingTimeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Thời gian đọc",
                        suffixText: "phút",
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
                    _isUpdatePost ? "Cập nhật bài viết" : "Tạo bài viết mới",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    String name = _nameController.text;
    String contentHeader = _contentHeaderController.text;
    String contentBody = _contentBodyController.text;
    String readingTime = _readingTimeController.text;
    if (_formKey.currentState!.validate() && _isLoading == false) {
      setState(() {
        _isLoading = true;
      });
      Post post = Post(
        postID: _postID,
        contentBody: contentBody,
        contentHeader: contentHeader,
        imageUrl: _imageUrl.toString(),
        readingTime: int.parse(readingTime),
        name: name,
        coachProfile:
            _selectedCoach != null ? _selectedCoach as Coach : _listCoaches[0],
      );
      if (!_isUpdatePost)
        _presenter.addPost(post);
      else
        _presenter.updatePost(post);
    }
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

  @override
  void backToPostScreen(int? deletedPostID) {
    Navigator.pop(context, deletedPostID);
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
  void showSuccessModal(Post post, String message) {
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

  @override
  void updateImageUrl(String? imageUrl) {
    setState(() {
      _isUploadingImage = false;
      _imageUrl = imageUrl;
      _isLoading = false;
    });
  }

  @override
  void loadCoaches(List<Coach> listCoaches) {
    setState(() {
      this._listCoaches = listCoaches;
      _isLoading = false;
    });
  }
}
