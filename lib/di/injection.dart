import 'package:fitme_admin_app/constants/cloudinary_preset.dart';
import 'package:fitme_admin_app/repository/auth_repository.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/post_repository.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';
import 'package:fitme_admin_app/repository/user_repository.dart';
import 'package:fitme_admin_app/services/auth_service.dart';
import 'package:fitme_admin_app/services/cloudinary_service.dart';
import 'package:fitme_admin_app/services/coach_service.dart';
import 'package:fitme_admin_app/services/post_service.dart';
import 'package:fitme_admin_app/services/tag_service.dart';
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

  ImageRepository get coachImageRepository =>
      new CloudinaryService(preset: CloudinaryPreset.coach);

  ImageRepository get postImageRepository =>
      new CloudinaryService(preset: CloudinaryPreset.post);

  TagRepository get tagRepository => new TagService();

  PostRepository get postRepository => new PostService();
}
