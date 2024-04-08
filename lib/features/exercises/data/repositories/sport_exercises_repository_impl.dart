
import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../domain/repositories/sport_exercises_repository.dart';
import '../datasources/local_exercises_datasource.dart';
import '../datasources/mock_excercises_datasource.dart';

class SportExercisesRepositoryImpl implements SportExercisesRepository {
  SportExercisesRepositoryImpl(this.localExercisesDatasource, this.exercisesDatasource);
  final LocalExercisesDatasource localExercisesDatasource;
  final MockExersisesDatasource exercisesDatasource;

  @override
  Future<void> addExercise(SportExercise exercise) {
    return localExercisesDatasource.addExercise(exercise);
  }

  @override
  Future<void> editExercise(SportExercise exercise) {
    return localExercisesDatasource.editExercise(exercise);
  }

  @override
  Future<List<SportExercise>> getExercises() async {
    if ((await localExercisesDatasource.getExercises()).isEmpty) {
      List<SportExercise> exercises = await exercisesDatasource.getExercises();
      for (final exercise in exercises) {
        localExercisesDatasource.addExercise(exercise);
      }
      return exercises;
    } else {
      return localExercisesDatasource.getExercises();
    }
  }
  
  @override
  Future<void> deleteExercise(String uuid) async {
    localExercisesDatasource.deleteExercise(uuid);
  }
}