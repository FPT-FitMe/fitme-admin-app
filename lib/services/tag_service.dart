import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/tag.dart';
import 'package:fitme_admin_app/repository/tag_repository.dart';

class TagService implements TagRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<Tag> addTag(Tag tag) async {
    final response = await dio.post("/tags", data: jsonEncode(tag));
    return Tag.fromJson(response.data);
  }

  @override
  Future<int?> disableTag(int tagID) async {
    final response = await dio.patch("/tags/$tagID", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? tagID : null;
  }

  @override
  Future<List<Tag>> getAllTags() async {
    final response = await dio.get("/tags");
    return (response.data as List).map((tag) => Tag.fromJson(tag)).toList();
  }

  @override
  Future<List<Tag>> getTagByType(String type) async {
    final response = await dio.get("/tags", queryParameters: {"tagType": type});
    return (response.data as List).map((tag) => Tag.fromJson(tag)).toList();
  }

  @override
  Future<Tag> updateTag(Tag tag) async {
    final response = await dio.put("/tags/${tag.id}", data: jsonEncode(tag));
    return Tag.fromJson(response.data);
  }
}
