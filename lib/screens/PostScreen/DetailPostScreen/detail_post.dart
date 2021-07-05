import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:flutter/material.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({Key? key}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa bài viết"),
  ];
  bool _isLoading = false;
  bool _isUpdatePost = false;
  Coach? selectedCoach;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contentBodyController = TextEditingController();
  TextEditingController _contentHeaderController = TextEditingController();
  TextEditingController _readingTimeController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Post? post = ModalRoute.of(context)!.settings.arguments as Post?;
    if (post != null) {
      setState(() {
        _isUpdatePost = true;
      });
      _nameController.text = post.postName;
      _contentBodyController.text = post.contentBody;
      _contentHeaderController.text = post.contentHeader;
      _readingTimeController.text = post.readingTime.toString();
      _imageUrlController.text = post.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdatePost == false ? "Thêm món ăn" : post!.postName,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdatePost)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {},
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
                child: CircleAvatar(
                  radius: 40,
                  child: post != null ? null : Icon(Icons.add_a_photo),
                  backgroundImage: post != null
                      ? NetworkImage(post.imageUrl.toString())
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
                        labelText: "Tên bài viết",
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
}
