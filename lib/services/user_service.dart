import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';

class UserService implements UserRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<List<User>> getAllUsers() async {
    final response = await dio.get('/users');
    return (response.data as List).map((user) => User.fromJson(user)).toList();
  }

  @override
  Future<bool> disableUser(int userID) async {
    final response = await dio.patch('/users/disable/$userID', data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? true : false;
  }
}
