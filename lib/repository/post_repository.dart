import 'package:fitme_admin_app/models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getAllPosts();
  Future<Post> addPost(Post post);
  Future<Post> updatePost(Post post);
  Future<int?> disablePost(int id);
}
