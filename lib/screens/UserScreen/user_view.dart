import 'package:fitme_admin_app/models/user.dart';

abstract class UserView {
  void loadUsers(List<User> listUsers);
  void refresh() {}
}
