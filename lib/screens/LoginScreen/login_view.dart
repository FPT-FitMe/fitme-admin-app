import 'package:fitme_admin_app/models/user.dart';

abstract class LoginView {
  void loginSuccess(User user);
  void loginFail(String errorMessage);
}
