import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:flutter/material.dart';

class DetailCoachScreen extends StatefulWidget {
  const DetailCoachScreen({Key? key}) : super(key: key);

  @override
  _DetailCoachScreenState createState() => _DetailCoachScreenState();
}

class _DetailCoachScreenState extends State<DetailCoachScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa huấn luyện viên"),
  ];
  bool _isLoading = false;
  bool _isUpdateCoach = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Coach? coach = ModalRoute.of(context)!.settings.arguments as Coach?;
    if (coach != null) {
      setState(() {
        _isUpdateCoach = true;
      });
      _nameController.text = coach.name;
      _introductionController.text = coach.introduction;
      _contactController.text = coach.contact.toString();
      _imageUrlController.text = coach.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateCoach == false ? "Thêm huấn luyện viên" : coach!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdateCoach)
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
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 40,
                    child: coach != null ? null : Icon(Icons.add_a_photo),
                    backgroundImage: coach != null
                        ? NetworkImage(coach.imageUrl.toString())
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Số điện thoại liên hệ",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // TextFormField(
                    //   controller: _imageUrlController,
                    //   keyboardType: TextInputType.url,
                    //   decoration: InputDecoration(
                    //     labelText: "Url hình đại diện",
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
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
}
