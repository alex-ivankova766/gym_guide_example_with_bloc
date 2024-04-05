import '../../../../shared/domain/entities/sport_excercise.dart';

abstract class SportExercisesRepository {
  Future<List<SportExercise>> getExercises();
  Future<void> addExercise(SportExercise exercise);
  Future<void> editExercise(SportExercise exercise);
}