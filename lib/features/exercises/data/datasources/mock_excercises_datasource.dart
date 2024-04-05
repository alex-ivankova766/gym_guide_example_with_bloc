import '../../../../shared/data/datasources/sports_exercises.dart';
import '../../../../shared/data/models/sport_exercise_model.dart';
import '../../../../shared/domain/entities/sport_excercise.dart';

abstract class MockExersisesDatasource {
  Future<List<SportExercise>> getExercises();
}

class MockExersisesDatasourceImpl implements MockExersisesDatasource {
  @override
  Future<List<SportExercise>> getExercises() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
    return sportExercises
        .map((exercise) => SportExerciseModel.fromJson(exercise).toEntity())
        .toList();
  }
}
