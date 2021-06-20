import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:fitme_admin_app/screens/LoginScreen/login_view.dart';

class LoginPresenter {
  LoginView _loginView;
  late AuthRepository _authRepository;

  LoginPresenter(this._loginView) {
    _authRepository = new Injector().authRepository;
  }

  void login(String email, String password) {
    // TODO: add logic here
    if (email.isNotEmpty) {
      _authRepository
          .login()
          .then((user) => {_loginView.loginSuccess()})
          .catchError((error) {
        print(error);
      });
    }
  }
}
