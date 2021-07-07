import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/post.dart';
import 'package:fitme_admin_app/repository/post_repository.dart';

class PostService implements PostRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<Post> addPost(Post post) async {
    final response = await dio.post("/posts", data: jsonEncode(post));
    return Post.fromJson(response.data);
  }

  @override
  Future<int?> disablePost(int id) async {
    final response = await dio.patch("/posts/$id", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? id : null;
  }

  @override
  Future<List<Post>> getAllPosts() async {
    final response = await dio.get("/posts");
    return (response.data as List).map((post) => Post.fromJson(post)).toList();
  }

  @override
  Future<Post> updatePost(Post post) async {
    final response =
        await dio.put("/posts/${post.postID}", data: jsonEncode(post));
    return Post.fromJson(response.data);
  }
}
