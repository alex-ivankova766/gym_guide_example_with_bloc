
import 'package:flutter/material.dart';

import '../../../../shared/domain/entities/sport_excercise.dart';

abstract class LocalExercisesDatasource {
  Future<List<SportExercise>> getExercises();
  Future<void> addExercise(SportExercise exercise);
  Future<void> editExercise(SportExercise exercise);
}

class LocalExercisesDatasourceImpl extends LocalExercisesDatasource {

  @override
  Future<void> addExercise(SportExercise exercise) async {
    debugPrint(exercise.title);
  }
  
  @override
  Future<void> editExercise(SportExercise exercise) {
    // TODO: implement editExercise
    throw UnimplementedError();
  }
  
  @override
  Future<List<SportExercise>> getExercises() async {
    return [];
  }
}