import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/services/auth_service.dart';
import 'package:fitme_admin_app/services/user_service.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AuthRepository get authRepository {
    return new AuthService();
  }

  UserRepository get userRepository {
    return new UserService();
  }
}
