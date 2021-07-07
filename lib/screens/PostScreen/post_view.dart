import 'package:fitme_admin_app/models/post.dart';

abstract class PostView {
  void loadPosts(List<Post> listPosts);
  void refresh();
  void showFailedModal(String message);
  void showEmptyList();
}
