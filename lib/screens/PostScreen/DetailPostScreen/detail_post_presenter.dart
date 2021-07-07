import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';
import 'package:fitme_admin_app/repository/image_repository.dart';
import 'package:fitme_admin_app/repository/post_repository.dart';
import 'package:fitme_admin_app/screens/PostScreen/DetailPostScreen/detail_post_view.dart';

class DetailPostPresenter {
  DetailPostView _detailPostView;
  late PostRepository _postRepository;
  late CoachRepository _coachRepository;
  late ImageRepository _imageRepository;

  DetailPostPresenter(this._detailPostView) {
    _postRepository = new Injector().postRepository;
    _imageRepository = new Injector().postImageRepository;
    _coachRepository = new Injector().coachRepository;
  }

  void uploadImage(String imagePath) async {
    try {
      String? imageUrl = await _imageRepository.uploadImage(imagePath);
      _detailPostView.updateImageUrl(imageUrl);
    } catch (e) {
      print(e);
      _detailPostView.showFailedModal("Lỗi khi upload ảnh");
    }
  }

  void addPost(Post post) async {
    try {
      Post addedPost = await _postRepository.addPost(post);
      _detailPostView.showSuccessModal(
          addedPost, "Thêm ${post.name} thành công");
    } catch (e) {
      print(e);
      _detailPostView.showFailedModal("Lỗi khi thêm bài viết");
    }
  }

  void updatePost(Post post) async {
    try {
      Post updatedPost = await _postRepository.updatePost(post);
      _detailPostView.showSuccessModal(
          updatedPost, "Cập nhật ${post.name} thành công");
    } catch (e) {
      print(e);
    }
  }

  void deletePost(int id) async {
    try {
      int? deletedPostID = await _postRepository.disablePost(id);
      _detailPostView.backToPostScreen(deletedPostID);
    } catch (e) {
      print(e);
    }
  }

  void loadAllCoaches() async {
    try {
      List<Coach> listCoaches = await _coachRepository.getAllCoaches();
      _detailPostView.loadCoaches(listCoaches);
    } catch (e) {
      print(e);
    }
  }
}
