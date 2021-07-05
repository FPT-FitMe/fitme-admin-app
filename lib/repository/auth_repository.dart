import 'package:fitme_admin_app/models/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}
