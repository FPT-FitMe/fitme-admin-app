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
    // TODO: should return user in response
    final response = await dio.post('/authentication/login', data: {
      'username': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      await _storage.write(key: "userToken", value: response.data["jwt"]);
      return User();
    } else {
      throw Exception('Failed to login user');
    }
  }
}
