import 'package:fitme_admin_app/models/exercise.dart';
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

final List<Exercise> fakeListExercises = [
  Exercise(
    exerciseID: 1,
    baseDuration: 2,
    baseRepPerRound: 5,
    description: "Lorem Ipsum",
    exerciseOrder: 1,
    imageUrl:
        "https://images.unsplash.com/photo-1594737625785-a6cbdabd333c?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
    name: "Hít đất",
    videoUrl: "pushup.gif",
  ),
  Exercise(
    exerciseID: 2,
    baseDuration: 1,
    baseRepPerRound: 12,
    description: "Lorem Ipsum",
    exerciseOrder: 2,
    imageUrl:
        "https://images.unsplash.com/photo-1594737625992-ef391874b13e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=80",
    name: "Vặn người",
    videoUrl: "pushup.gif",
  ),
];
