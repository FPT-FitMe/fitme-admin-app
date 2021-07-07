import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/services/auth_service.dart';
import 'package:fitme_admin_app/services/cloudinary_service.dart';
import 'package:fitme_admin_app/services/coach_service.dart';
import 'package:fitme_admin_app/services/user_service.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AuthRepository get authRepository => new AuthService();

  UserRepository get userRepository => new UserService();

  CoachRepository get coachRepository => new CoachService();

  ImageRepository get imageRepository => new CloudinaryService();
}
