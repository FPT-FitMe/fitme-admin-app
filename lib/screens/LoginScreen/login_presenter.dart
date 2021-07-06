import 'package:dio/dio.dart';
import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/auth_user.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:fitme_admin_app/screens/LoginScreen/login_view.dart';

class LoginPresenter {
  LoginView _loginView;
  late AuthRepository _authRepository;

  LoginPresenter(this._loginView) {
    _authRepository = new Injector().authRepository;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty) {
        AuthUser user = await _authRepository.login(email, password);
        _loginView.loginSuccess(user);
      }
    } on DioError {
      _loginView.loginFail("Email hoặc password không hợp lệ");
    } catch (e) {
      _loginView.loginFail("Unexpected errors");
    }
  }
}
