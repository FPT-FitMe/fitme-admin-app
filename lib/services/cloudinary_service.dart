import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fitme_admin_app/constants/cloudinary_preset.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';

class CloudinaryService implements ImageRepository {
  static const String _cloudName = "fitme-media";
  final String preset;
  late final _cloudinary;

  CloudinaryService({this.preset = CloudinaryPreset.coach}) {
    _cloudinary = CloudinaryPublic(_cloudName, preset, cache: false);
  }

  @override
  Future<String?> uploadImage(String imagePath) async {
    try {
      CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      print(e.message);
    }
    return null;
  }
}
