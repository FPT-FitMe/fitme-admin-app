import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:flutter/material.dart';

class DetailExerciseScreen extends StatefulWidget {
  const DetailExerciseScreen({Key? key}) : super(key: key);

  @override
  _DetailExerciseScreenState createState() => _DetailExerciseScreenState();
}

class _DetailExerciseScreenState extends State<DetailExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa bài tập"),
  ];
  bool _isLoading = false;
  bool _isUpdateExercise = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _baseRepController = TextEditingController();
  TextEditingController _baseDurationController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();
  TextEditingController _videoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Exercise? exercise =
        ModalRoute.of(context)!.settings.arguments as Exercise?;
    if (exercise != null) {
      setState(() {
        _isUpdateExercise = true;
      });
      _nameController.text = exercise.name;
      _descriptionController.text = exercise.description;
      _baseRepController.text = exercise.baseRepPerRound.toString();
      _baseDurationController.text = exercise.baseDuration.toString();
      _imageUrlController.text = exercise.imageUrl;
      _videoUrlController.text = exercise.videoUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateExercise == false ? "Thêm bài tập" : exercise!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdateExercise)
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
                  child: exercise != null ? null : Icon(Icons.add_a_photo),
                  backgroundImage: exercise != null
                      ? NetworkImage(exercise.imageUrl.toString())
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
                        labelText: "Tên bài tập",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: "Link hình bài tập",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _videoUrlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: "Link video bài tập",
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
}
