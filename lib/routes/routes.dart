import 'package:fitme_admin_app/constants/routes.dart';
import 'package:fitme_admin_app/screens/AchievementScreen/achievement.dart';
import 'package:fitme_admin_app/screens/CoachScreen/DetailCoachScreen/detail_coach.dart';
import 'package:fitme_admin_app/screens/CoachScreen/coach.dart';
import 'package:fitme_admin_app/screens/DashboardScreen/dashboard.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/DetailExerciseScreen/detail_excercise.dart';
import 'package:fitme_admin_app/screens/LoginScreen/login.dart';
import 'package:fitme_admin_app/screens/MealScreen/meal.dart';
import 'package:fitme_admin_app/screens/PostScreen/post.dart';
import 'package:fitme_admin_app/screens/TagScreen/tag.dart';
import 'package:fitme_admin_app/screens/UserScreen/DetailUserScreen/detail_user.dart';
import 'package:fitme_admin_app/screens/UserScreen/user.dart';
import 'package:fitme_admin_app/screens/ExerciseScreen/exercise.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/DetailWorkoutScreen/detail_workout.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/WorkoutExerciseScreen/workout_exercise.dart';
import 'package:fitme_admin_app/screens/WorkoutScreen/workout.dart';

getRoutes() {
  return {
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.dashboard: (context) => DashboardScreen(),
    AppRoutes.users: (context) => UserScreen(),
    AppRoutes.detailUser: (context) => DetailUserScreen(),
    AppRoutes.coaches: (context) => CoachScreen(),
    AppRoutes.detailCoach: (context) => DetailCoachScreen(),
    AppRoutes.exercises: (context) => ExerciseScreen(),
    AppRoutes.detailExercise: (context) => DetailExerciseScreen(),
    AppRoutes.workouts: (context) => WorkoutScreen(),
    AppRoutes.detailWorkout: (context) => DetailWorkoutScreen(),
    AppRoutes.workoutExercises: (context) => WorkoutExerciseScreen(),
    AppRoutes.meals: (context) => MealScreen(),
    AppRoutes.posts: (context) => PostScreen(),
    AppRoutes.tags: (context) => TagScreen(),
    AppRoutes.achievements: (context) => AchievementScreen(),
  };
}
