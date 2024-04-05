import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/entities/sport_excercise.dart';
import '../../domain/entities/enums.dart';

class SportExerciseModel {
  const SportExerciseModel({
    required this.uuid,
    required this.title,
    required this.description,
    required this.exersizeType,
    required this.level,
    required this.duration,
    required this.repetitions,
  });

  final String uuid;
  final String title;
  final String description;
  final SportExersizeType exersizeType;
  final DificultyLevel level;
  final Duration duration;
  final List<int> repetitions;

  factory SportExerciseModel.fromJson(Map<String, dynamic> exercise) {
    debugPrint(jsonEncode(exercise));
    try {
return SportExerciseModel(
      uuid: exercise['uuid'],
      title: exercise['title'],
      description: exercise['description'],
      exersizeType: SportExersizeTypeExt.fromJson(exercise['exersizeType']) ?? SportExersizeType.empty,
      level: DificultyLevelExt.fromJson(exercise['level']) ?? DificultyLevel.empty,
      duration: Duration(minutes: exercise['duration']),
      repetitions: List<int>.from(exercise['repetitions']),
    );
    }catch (error) {
debugPrint(jsonEncode(error));
return SportExerciseModel.fromEntity(SportExercise.empty());
    }
    
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'description': description,
      'exersizeType': exersizeType.toJson(),
      'level': level.toJson(),
      'duration': duration.inMinutes,
      'repetitions': jsonEncode(repetitions),
    };
  }

  factory SportExerciseModel.fromEntity(SportExercise exercise) {
    return SportExerciseModel(
      uuid: exercise.uuid,
      title: exercise.title,
      description: exercise.description,
      exersizeType: exercise.exersizeType,
      level: exercise.level,
      duration: exercise.duration,
      repetitions: exercise.repetitions,
    );
  }

  SportExercise toEntity() {
    return SportExercise(uuidFromDB: uuid,
      title: title,
      description: description,
      exersizeType: exersizeType,
      level: level,
      duration: duration,
      repetitions: repetitions,);
  }
}
