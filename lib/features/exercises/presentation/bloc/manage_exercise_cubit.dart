import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../domain/usecases/usecases.dart';

part 'manage_exercise_state.dart';

class ManageExerciseCubit extends Cubit<ManageExercisesState> {
  final AddExercise _addExercise;
  final EditExercise _editExercise;
  final GetExercises _getExercises;
  final DeleteExercise _deleteExercise;

  ManageExerciseCubit({
    required AddExercise addExercise,
    required EditExercise editExercise,
    required GetExercises getExercises,
    required DeleteExercise deleteExercise,
  })  : _addExercise = addExercise,
        _editExercise = editExercise,
        _getExercises = getExercises,
        _deleteExercise = deleteExercise,
        super(ExercisesLoading()) {
    getAllExercises();
  }

  Future<void> getAllExercises() async {
    List<SportExercise> exercises = await _getExercises(NoParams());
    emit(ExercisesLoaded(exercises: exercises));
  }

  Future<void> addExercise(SportExercise exercise) async {
    try {
      await _addExercise(AddExerciseParams(exercise: exercise));
      if (state is ExercisesLoaded) {
        emit(ExercisesLoaded(
            exercises: [...(state as ExercisesLoaded).exercises, exercise]));
      }
    } catch (error) {
      debugPrint('Failed to add exercise: $error');
    }
  }

  Future<void> deleteExercise(String uuid) async {
    try {
      await _deleteExercise(DeleteExerciseParams(uuid: uuid));
      if (state is ExercisesLoaded) {
        List<SportExercise> exercisesAfterDelete =
            (state as ExercisesLoaded).exercises;
        exercisesAfterDelete.removeWhere(
          (element) => element.uuid == uuid,
        );
        emit(ExercisesLoading());
        emit(ExercisesLoaded(exercises: exercisesAfterDelete));
      }
    } catch (error) {
      debugPrint('Failed to delete exercise: $error');
    }
  }

  Future<void> editExercise(SportExercise exercise) async {
    try {
      await _editExercise(EditExerciseParams(exercise: exercise));
      if (state is ExercisesLoaded) {
        List<SportExercise> exercisesAfterEdit =
            (state as ExercisesLoaded).exercises;
        int changingIndex =
            exercisesAfterEdit.indexOf(exercisesAfterEdit.firstWhere(
          (element) => element.uuid == exercise.uuid,
        ));
        exercisesAfterEdit[changingIndex] = exercise;
        emit(ExercisesLoading());
        emit(ExercisesLoaded(exercises: exercisesAfterEdit));
      }
    } catch (error) {
      debugPrint('Failed to edit exercise: $error');
    }
  }
}
