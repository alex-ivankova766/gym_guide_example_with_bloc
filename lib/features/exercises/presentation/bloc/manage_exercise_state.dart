part of 'manage_exercise_cubit.dart';

abstract class ManageExercisesState extends Equatable {
  const ManageExercisesState();

  @override
  List<Object> get props => [];
}

class ExercisesLoading extends ManageExercisesState {}

class ExercisesLoaded extends ManageExercisesState {
  const ExercisesLoaded({this.exercises = const <SportExercise>[]});
  final List<SportExercise> exercises;
  @override
  List<Object> get props => [exercises];
}