import 'package:fitme_admin_app/models/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  bool disableUser();
}
