import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/user.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';

class UserService implements UserRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<List<User>> getAllUsers() async {
    List<User> users;
    final response = await dio.get('/users');
    users = (response.data as List).map((user) => User.fromJson(user)).toList();
    print(users);
    return users;
  }

  @override
  bool disableUser() {
    // TODO: implement disableUser
    throw UnimplementedError();
  }
}
