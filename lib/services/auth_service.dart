import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService implements AuthRepository {
  Dio dio = new HttpService().dio;
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  @override
  Future<User> login(String email, String password) async {
    final response = await dio.post('/authentication/login', data: {
      'username': email,
      'password': password,
    });
    await _storage.write(key: "userToken", value: response.data["jwt"]);
    // TODO: should return user in response
    return User(
        age: 20,
        email: 'fitmeadmin@gmail.com',
        gender: 1,
        height: 168,
        userID: 2,
        imageUrl:
            'https://images.unsplash.com/photo-1569913486515-b74bf7751574?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=635&q=80',
        phone: '8412345678',
        username: 'fitmeadmin');
  }
}
