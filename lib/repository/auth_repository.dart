import 'package:fitme_admin_app/models/auth_user.dart';

abstract class AuthRepository {
  Future<AuthUser> login(String email, String password);
  Future<String?> refreshToken();
}
