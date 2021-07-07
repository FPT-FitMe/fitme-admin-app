import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/screens/TagScreen/DetailTagDialog/detail_tag_view.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'detail_tag_presenter.dart';

class DetailTagDialog extends StatefulWidget {
  final Function? onRefresh;
  const DetailTagDialog({
    Key? key,
    this.onRefresh,
  }) : super(key: key);

  @override
  _DetailTagDialogState createState() =>
      _DetailTagDialogState(onRefresh: onRefresh);
}

class _DetailTagDialogState extends State<DetailTagDialog>
    implements DetailTagView {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  late DetailTagPresenter _presenter;
  String _selectedTagType = TagTypes.meal;
  bool _isUpdateTag = false;
  int? _tagID;
  final Function? onRefresh;
  final List<String> tagTypes = ["Món ăn", "Bài tập"];

  _DetailTagDialogState({this.onRefresh}) {
    _presenter = new DetailTagPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    final Tag? tag = ModalRoute.of(context)!.settings.arguments as Tag?;
    if (tag != null) {
      setState(() {
        _isUpdateTag = true;
      });
      _tagID = tag.id;
      _nameController.text = tag.name;
      _selectedTagType = tag.type.toString();
    }
    return AlertDialog(
      title: _isUpdateTag ? Text("Cập nhật tag") : Text("Tạo tag mới"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Container(
        height: 280,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Tên",
                ),
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "* Bắt buộc"),
                    MaxLengthValidator(255, errorText: "Tối đa 255 ký tự"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    value: TagTypes.meal,
                    child: Text("Món ăn"),
                  ),
                  DropdownMenuItem(
                    value: TagTypes.exercise,
                    child: Text("Bài tập"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedTagType = value.toString();
                  });
                },
                value: _selectedTagType,
                decoration: InputDecoration(labelText: "Loại tag"),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    _isUpdateTag ? "Cập nhật tag" : "Tạo tag mới",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showFailedModal(String message) {
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
  void showSuccessModal(Tag tag, String message) {
    Alert(
      context: context,
      type: AlertType.success,
      title: message,
      buttons: [],
    ).show();
    Future.delayed(new Duration(seconds: 2), () {
      Navigator.pop(context);
    });
    if (onRefresh != null) {
      tag.type == TagTypes.exercise
          ? onRefresh!(TagTypes.exercise)
          : onRefresh!(TagTypes.meal);
    }
  }

  void _submitForm() {
    String name = _nameController.text;
    if (_formKey.currentState!.validate()) {
      Tag tag = Tag(id: _tagID, name: name, type: _selectedTagType);
      if (!_isUpdateTag)
        _presenter.addTag(tag);
      else
        _presenter.updateTag(tag);
    }
  }
}
