import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';

class CloudinaryService implements ImageRepository {
  static const String _cloudName = "fitme-media";
  static const String _uploadPreset = "fitme-user";
  final _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);

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
