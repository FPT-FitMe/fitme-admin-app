import 'package:fitme_admin_app/screens/DashboardScreen/dashboard.dart';
import 'package:fitme_admin_app/screens/LoginScreen/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'configs/themes.dart';
import 'routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitMe Admin',
      theme: AppThemes.defaultTheme,
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      home: FutureBuilder(
        future: _checkUserLogin(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return DashboardScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }

  Future<String?> _checkUserLogin() async {
    FlutterSecureStorage _storage = new FlutterSecureStorage();
    var userToken = await _storage.read(key: "userToken");
    print("Token $userToken");
    return userToken;
  }
}
