import 'package:fitme_admin_app/constants/tag_types.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:flutter/material.dart';

class DetailTagDialog extends StatefulWidget {
  const DetailTagDialog({
    Key? key,
  }) : super(key: key);

  @override
  _DetailTagDialogState createState() => _DetailTagDialogState();
}

class _DetailTagDialogState extends State<DetailTagDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  int _selectedTagType = TagTypes.exercise;
  bool _isUpdateTag = false;
  final List<String> tagTypes = ["Món ăn", "Bài tập"];

  @override
  Widget build(BuildContext context) {
    final Tag? tag = ModalRoute.of(context)!.settings.arguments as Tag?;
    if (tag != null) {
      setState(() {
        _isUpdateTag = true;
      });
      _nameController.text = tag.name;
      _selectedTagType = tag.type;
    }
    return AlertDialog(
      title: _isUpdateTag ? Text("Cập nhật tag") : Text("Tạo tag mới"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      content: Container(
        height: 250,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Tên",
                  focusedBorder: InputBorder.none,
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
                    _selectedTagType = int.parse(value.toString());
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
                  onPressed: () {},
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
}
