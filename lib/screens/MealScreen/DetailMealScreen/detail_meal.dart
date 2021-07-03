import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:flutter/material.dart';

class DetailMealScreen extends StatefulWidget {
  const DetailMealScreen({Key? key}) : super(key: key);

  @override
  _DetailMealScreenState createState() => _DetailMealScreenState();
}

class _DetailMealScreenState extends State<DetailMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa món ăn"),
  ];
  bool _isLoading = false;
  bool _isUpdateCoach = false;
  bool? _isPremium = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _cookingTimeController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();
  TextEditingController _carbAmountController = TextEditingController();
  TextEditingController _fatAmountController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Meal? meal = ModalRoute.of(context)!.settings.arguments as Meal?;
    if (meal != null) {
      setState(() {
        _isUpdateCoach = true;
      });
      _nameController.text = meal.name;
      _descriptionController.text = meal.description;
      _cookingTimeController.text = meal.cookingTime.toString();
      _caloriesController.text = meal.calories.toString();
      _carbAmountController.text = meal.carbAmount.toString();
      _fatAmountController.text = meal.fatAmount.toString();
      _imageUrlController.text = meal.imageUrl;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateCoach == false ? "Thêm món ăn" : meal!.name,
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
                child: CircleAvatar(
                  radius: 40,
                  child: meal != null ? null : Icon(Icons.add_a_photo),
                  backgroundImage: meal != null
                      ? NetworkImage(meal.imageUrl.toString())
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
                        labelText: "Tên món ăn",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _cookingTimeController,
                      decoration: InputDecoration(
                        labelText: "Thời gian nấu",
                        suffixText: "phút",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Mô tả món ăn",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng calories trong món ăn",
                        suffixText: "cals",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _carbAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng carb trong món ăn",
                        suffixText: "g",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _fatAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng chất béo trong món ăn",
                        suffixText: "g",
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   controller: _imageUrlController,
                    //   keyboardType: TextInputType.url,
                    //   decoration: InputDecoration(
                    //     labelText: "Url hình món ăn",
                    //   ),
                    // ),
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
                    _isUpdateCoach ? "Cập nhật món ăn" : "Tạo món ăn mới",
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
