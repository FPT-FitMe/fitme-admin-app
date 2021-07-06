import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/auth_user.dart';
import 'package:fitme_admin_app/models/errors/AuthUserException.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService implements AuthRepository {
  Dio dio = new HttpService().dio;
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  @override
  Future<AuthUser> login(String email, String password) async {
    final response = await dio.post('/authentication/login', data: {
      'email': email,
      'password': password,
    });
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    final AuthUser user = AuthUser.fromJson(response.data["user"]);
    if (user.role == "ROLE_MANAGER") {
      _sharedPreferences.setString(
          "name", user.firstName + " " + user.lastName);
      _sharedPreferences.setString("imageUrl", user.profileImageUrl);
      await _storage.write(key: "userToken", value: response.data["jwtToken"]);
      return user;
    } else {
      throw AuthUserException(
        message: "Tài khoản bạn đăng nhập không phải là quản trị viên",
      );
    }
  }

  @override
  Future<String?> refreshToken() async {
    final response = await dio.get('/authentication/refreshToken');
    await _storage.write(key: "userToken", value: response.data["jwt"]);
    return response.data["jwt"];
  }
}
