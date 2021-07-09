import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitme_admin_app/configs/http_service.dart';
import 'package:fitme_admin_app/models/exercise.dart';
import 'package:fitme_admin_app/models/workout.dart';
import 'package:fitme_admin_app/models/workout_exercise.dart';
import 'package:fitme_admin_app/repository/workout_repository.dart';

class WorkoutService implements WorkoutRepository {
  Dio dio = new HttpService().dio;

  @override
  Future<Workout> addWorkout(Workout workout) async {
    final response = await dio.post("/workouts", data: jsonEncode(workout));
    return Workout.fromJson(response.data);
  }

  @override
  Future<int?> disableWorkout(int id) async {
    final response = await dio.patch("/workouts/$id", data: [
      {"op": "replace", "path": "/isActive", "value": false}
    ]);
    return response.statusCode == 200 ? id : null;
  }

  @override
  Future<List<Workout>> getAllWorkouts() async {
    final response = await dio.get("/workouts");
    return (response.data as List)
        .map((workout) => Workout.fromJson(workout))
        .toList();
  }

  @override
  Future<Workout> updateWorkout(Workout workout) async {
    final response = await dio.put("/workouts/${workout.workoutID}",
        data: jsonEncode(workout));
    return Workout.fromJson(response.data);
  }

  @override
  Future<List<WorkoutExercise>> createListExerciseOfWorkout(
      int workoutID, List<Exercise> exercises) async {
    final response = await dio.post("/workout_exercise?workoutID=$workoutID",
        data: jsonEncode(exercises));
    return (response.data as List)
        .map((exercise) => WorkoutExercise.fromJson(exercise))
        .toList();
  }

  @override
  Future<List<WorkoutExercise>> getListExerciseOfWorkout(int workoutID) async {
    final response = await dio.get("/workout_exercise/$workoutID");
    return (response.data as List)
        .map((workout) => WorkoutExercise.fromJson(workout))
        .toList();
  }

  @override
  Future<List<WorkoutExercise>> updateListExerciseOfWorkout(
      int workoutID, List<Exercise> exercises) async {
    final response = await dio.post(
      "/workout_exercise/order?Workout_id=$workoutID",
      data: jsonEncode(exercises),
    );
    return (response.data as List)
        .map((exercise) => WorkoutExercise.fromJson(exercise))
        .toList();
  }
}
