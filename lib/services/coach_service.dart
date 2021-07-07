import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/coach.dart';
import 'package:fitme_admin_app/repository/coach_repository.dart';

class CoachService implements CoachRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<int?> disableCoach(int id) async {
    final response = await dio.patch("/coachs/$id", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? id : null;
  }

  @override
  Future<List<Coach>> getAllCoaches() async {
    final response = await dio.get("/coachs");
    return (response.data as List)
        .map((coach) => Coach.fromJson(coach))
        .toList();
  }

  @override
  Future<Coach> updateCoach(Coach coach) async {
    final response =
        await dio.put("/coachs/${coach.coachID}", data: jsonEncode(coach));
    return Coach.fromJson(response.data);
  }

  @override
  Future<Coach> addCoach(Coach coach) async {
    final response = await dio.post("/coachs", data: jsonEncode(coach));
    return Coach.fromJson(response.data);
  }
}
