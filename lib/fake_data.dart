import 'package:fitme_admin_app/models/workout.dart';

final List<Workout> fakeListWorkouts = [
  Workout(
    workoutID: 1,
    description: "Lorem  ipsum",
    estimatedCalories: 120,
    estimatedDuration: 5,
    isPremium: false,
    imageUrl:
        'https://images.unsplash.com/photo-1616803824305-a07cfbc8ea60?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    level: 1,
    name: '5 phút tập bụng',
  ),
  Workout(
    workoutID: 2,
    description: "Lorem  ipsum",
    estimatedCalories: 240,
    estimatedDuration: 10,
    isPremium: true,
    imageUrl:
        'https://images.unsplash.com/photo-1608138404239-d2f557515ecb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    level: 2,
    name: 'Tập cardio cùng Linh Nguyễn',
  ),
];
