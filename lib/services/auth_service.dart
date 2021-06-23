import 'package:dio/dio.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';

class AuthService implements AuthRepository {
  static const url = "https://jsonplaceholder.typicode.com/users/1";

  @override
  Future<User> login() async {
    // TODO: implement login
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to login user');
    }
  }
}
