import 'package:fitme_admin_app/di/injection.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/repository/post_repository.dart';
import 'package:fitme_admin_app/screens/PostScreen/post_view.dart';

class PostPresenter {
  PostView _postView;
  late PostRepository _postRepository;

  PostPresenter(this._postView) {
    _postRepository = new Injector().postRepository;
  }

  void loadAllPosts() async {
    try {
      List<Post> listPosts = await _postRepository.getAllPosts();
      _postView.loadPosts(listPosts);
    } catch (e) {
      _postView.showEmptyList();
      print(e);
    }
  }

  void deletePost(int id) async {
    try {
      await _postRepository.disablePost(id);
      _postView.refresh();
    } catch (e) {
      print(e);
    }
  }
}
