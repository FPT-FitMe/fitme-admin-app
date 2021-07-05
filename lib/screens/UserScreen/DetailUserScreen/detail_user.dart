import 'package:fitme_admin_app/constants/colors.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({Key? key}) : super(key: key);

  @override
  _DetailUserScreenState createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  late User user;

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
        actions: [
          PopupMenuButton<String>(
            offset: Offset(-20, 50),
            onSelected: (value) {},
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
                      labelText: "Giới tính",
                    ),
                    initialValue: user.gender == "M" ? "Nam" : "Nữ",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Chiều cao",
                    ),
                    initialValue:
                        double.tryParse(user.height.toString()) == null
                            ? ''
                            : user.height.toString(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Số điện thoại",
                    ),
                    initialValue: user.phoneNumber.toString(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
