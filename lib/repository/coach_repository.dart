import 'package:fitme_admin_app/models/coach.dart';

abstract class CoachRepository {
  Future<List<Coach>> getAllCoaches();
  Future<Coach> addCoach(Coach coach);
  Future<Coach> updateCoach(Coach coach);
  Future<int?> disableCoach(int id);
}
