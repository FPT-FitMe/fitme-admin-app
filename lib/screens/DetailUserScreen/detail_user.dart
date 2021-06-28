import 'package:fitme_admin_app/models/user.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({Key? key}) : super(key: key);

  @override
  _DetailUserScreenState createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  late User user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text(user.email),
      ),
    );
  }
}
