import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../domain/repositories/sport_exercises_repository.dart';
import '../datasources/local_exercises_datasource.dart';
import '../datasources/mock_excercises_datasource.dart';

class SportExercisesRepositoryImpl implements SportExercisesRepository {
  SportExercisesRepositoryImpl(this.localExercisesDatasource, this.excercisesDatasource);
  final LocalExercisesDatasource localExercisesDatasource;
  final MockExcersisesDatasource excercisesDatasource;

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
    debugPrint('Getting the posts from datasource');
    if ((await localExercisesDatasource.getExercises()).isEmpty) {
      List<SportExercise> exercises = await excercisesDatasource.getExcercises();
      for (final exercise in exercises) {
        localExercisesDatasource.addExercise(exercise);
      }
      return exercises;
    } else {
      return localExercisesDatasource.getExercises();
    }
  }
}