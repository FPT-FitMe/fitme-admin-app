import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/repository/exercise_repository.dart';

class ExerciseService implements ExerciseRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<Exercise> addExercise(Exercise exercise) async {
    final response = await dio.post("/exercises", data: jsonEncode(exercise));
    return Exercise.fromJson(response.data);
  }

  @override
  Future<int?> disableExercise(int id) async {
    final response = await dio.patch("/exercises/$id", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? id : null;
  }

  @override
  Future<List<Exercise>> getAllExercises() async {
    final response = await dio.get("/exercises");
    return (response.data as List)
        .map((exercise) => Exercise.fromJson(exercise))
        .toList();
  }

  @override
  Future<Exercise> updateExercise(Exercise exercise) async {
    final response = await dio.put("/exercises/${exercise.exerciseID}",
        data: jsonEncode(exercise));
    return Exercise.fromJson(response.data);
  }
}
