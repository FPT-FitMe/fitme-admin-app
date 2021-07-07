import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/post.dart';

abstract class DetailPostView {
  void showSuccessModal(Post post, String message);
  void updateImageUrl(String? imageUrl);
  void showFailedModal(String message);
  void backToPostScreen(int? deletedPostID);
  void loadCoaches(List<Coach> listCoaches);
}
