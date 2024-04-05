import '../../../../shared/data/datasources/sports_exercises.dart';
import '../../../../shared/data/models/sport_exercise_model.dart';
import '../../../../shared/domain/entities/sport_excercise.dart';

abstract class MockExcersisesDatasource {
  Future<List<SportExercise>> getExcercises();
}

class MockExcersisesDatasourceImpl implements MockExcersisesDatasource {
  @override
  Future<List<SportExercise>> getExcercises() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    return sportExercises
        .map((exercise) => SportExerciseModel.fromJson(exercise).toEntity())
        .toList();
  }
}
