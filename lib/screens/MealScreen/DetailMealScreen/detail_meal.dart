import 'package:community_material_icon/community_material_icon.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/meal.dart';
import 'package:fitme_admin_app/models/menu_item.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/MealScreen/DetailMealScreen/detail_meal_presenter.dart';
import 'package:fitme_admin_app/screens/MealScreen/DetailMealScreen/detail_meal_view.dart';
import 'package:fitme_admin_app/widgets/coach_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailMealScreen extends StatefulWidget {
  final Meal? meal;
  const DetailMealScreen({Key? key, this.meal}) : super(key: key);

  @override
  _DetailMealScreenState createState() => _DetailMealScreenState();
}

class _DetailMealScreenState extends State<DetailMealScreen>
    implements DetailMealView {
  final _formKey = GlobalKey<FormState>();
  final List<MenuItem> menuItems = [
    MenuItem(id: 1, title: "Xóa món ăn"),
  ];
  bool _isLoading = false;
  bool _isUpdateMeal = false;
  bool _isPremium = false;
  Coach? selectedCoach;
  bool _isUploadingImage = false;
  late DetailMealPresenter _presenter;
  late Meal? _meal;
  List<Coach> _listCoaches = [];
  List<Tag> _listTags = [];
  int? _mealID;
  String? _imageUrl;
  Coach? _selectedCoach;
  List<Tag> _selectedTags = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _cookingTimeController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();
  TextEditingController _carbAmountController = TextEditingController();
  TextEditingController _fatAmountController = TextEditingController();

  _DetailMealScreenState() {
    _presenter = new DetailMealPresenter(this);
    _presenter.loadAllCoaches();
    _presenter.loadMealTags();
  }

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
    if (_meal != null) {
      setState(() {
        _isUpdateMeal = true;
      });
      _mealID = _meal!.mealID;
      _isPremium = _meal!.isPremium;
      _nameController.text = _meal!.name;
      _descriptionController.text = _meal!.description;
      _cookingTimeController.text = _meal!.cookingTime.toString();
      _caloriesController.text = _meal!.calories.toString();
      _carbAmountController.text = _meal!.carbAmount.toString();
      _fatAmountController.text = _meal!.fatAmount.toString();
      _imageUrl = _meal!.imageUrl;
      _selectedCoach = _meal!.coachProfile;
      _selectedTags = _meal!.tags;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _isUpdateMeal == false ? "Thêm món ăn" : _meal!.name,
        ),
        centerTitle: true,
        actions: [
          if (_isUpdateMeal)
            PopupMenuButton<String>(
              offset: Offset(-20, 50),
              onSelected: (value) {
                if (value == "1") {
                  _presenter.deleteMeal(int.parse(_meal!.mealID.toString()));
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
                        labelText: "Tên món ăn",
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
                      controller: _cookingTimeController,
                      decoration: InputDecoration(
                        labelText: "Thời gian nấu",
                        suffixText: "phút",
                      ),
                      keyboardType: TextInputType.number,
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
                      controller: _descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Mô tả món ăn",
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
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng calories trong món ăn",
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
                    TextFormField(
                      controller: _carbAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng carb trong món ăn",
                        suffixText: "g",
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
                      controller: _fatAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Lượng chất béo trong món ăn",
                        suffixText: "g",
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
                      title: Text("Tag món ăn"),
                      cancelText: Text("Hủy bỏ"),
                      confirmText: Text("Xác nhận"),
                      buttonText: Text("Tag món ăn"),
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
                      onChanged: (value) {
                        setState(() {
                          _isPremium = value!;
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
                    _isUpdateMeal ? "Cập nhật món ăn" : "Tạo món ăn mới",
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
    String description = _descriptionController.text;
    int cookingTime = int.parse(_cookingTimeController.text);
    double calories = double.parse(_caloriesController.text);
    double carbAmount = double.parse(_carbAmountController.text);
    double fatAmount = double.parse(_fatAmountController.text);
    if (_formKey.currentState!.validate() && _isLoading == false) {
      setState(() {
        _isLoading = true;
      });
      Meal meal = Meal(
        mealID: _mealID,
        calories: calories,
        name: name,
        description: description,
        carbAmount: carbAmount,
        cookingTime: cookingTime,
        fatAmount: fatAmount,
        imageUrl: _imageUrl.toString(),
        isPremium: _isPremium,
        coachProfile: _selectedCoach,
        tags: _selectedTags,
      );
      if (!_isUpdateMeal)
        _presenter.addMeal(meal);
      else
        _presenter.updateMeal(meal);
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
  void backToMealScreen(int? deletedMealID) {
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
  void showSuccessModal(Meal meal, String message) {
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
  void loadTags(List<Tag> listTags) {
    setState(() {
      this._listTags = listTags;
      _isLoading = false;
    });
  }
}
