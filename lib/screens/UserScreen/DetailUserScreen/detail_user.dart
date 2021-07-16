import 'package:community_material_icon/community_material_icon.dart';
import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/screens/UserScreen/DetailUserScreen/detail_user_presenter.dart';
import 'package:fitme_admin_app/screens/UserScreen/DetailUserScreen/detail_user_view.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({Key? key}) : super(key: key);

  @override
  _DetailUserScreenState createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen>
    implements DetailUserView {
  late User user;
  late DetailUserPresenter _presenter;

  _DetailUserScreenState() {
    _presenter = new DetailUserPresenter(this);
  }

  final List<String> menuItems = ["Vô hiệu hóa tài khoản"];

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    print(user.profileImageUrl);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          user.firstName + " " + user.lastName,
          style: TextStyle(),
        ),
        centerTitle: true,
        actions: user.email == "admin@fitme.vn"
            ? null
            : [
                PopupMenuButton<String>(
                  offset: Offset(-20, 50),
                  onSelected: (value) {
                    if (value == "1") {
                      _presenter.disableUser(user.userID);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return menuItems
                        .map((choice) => PopupMenuItem<String>(
                              value: "1",
                              child: Text(
                                choice,
                                style: TextStyle(
                                  color: AppColors.red500,
                                ),
                              ),
                            ))
                        .toList();
                  },
                ),
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
                  backgroundImage: NetworkImage(user.profileImageUrl != null
                      ? user.profileImageUrl.toString()
                      : 'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80'),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Họ",
                    ),
                    initialValue: user.firstName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Tên",
                    ),
                    initialValue: user.lastName,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                    initialValue: user.email,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Số điện thoại",
                    ),
                    initialValue: user.phone != null ? user.phone.toString() : 'Chưa có thông tin',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Giới tính",
                    ),
                    initialValue: user.gender == 0 ? "Nam" : "Nữ",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Chiều cao",
                      suffixText: "cm",
                    ),
                    initialValue:
                        double.tryParse(user.height.toString()) == null
                            ? ''
                            : user.height.toString(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                    secondary: Icon(
                      CommunityMaterialIcons.professional_hexagon,
                    ),
                    title: Align(
                      child: Text("Thành viên pro"),
                      alignment: Alignment(-1.2, 0),
                    ),
                    value: user.isPremium == null || user.isPremium == false
                        ? false
                        : true,
                    onChanged: (bool? value) {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void backToUserScreen(int? deletedCoachID) {
    Navigator.pop(context, deletedCoachID);
  }
}
