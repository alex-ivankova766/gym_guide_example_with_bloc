
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'enums.dart';

class SportExercise extends Equatable {
  SportExercise({
    required String? uuidFromDB,
    required this.title,
    required this.description,
    required this.exersizeType,
    required this.level,
    required this.duration,
    required this.repetitions,
  }) : uuid = uuidFromDB ?? const Uuid().v4();

  final String uuid;
  final String title;
  final String description;
  final SportExersizeType exersizeType;
  final DificultyLevel level;
  final Duration duration;
  final List<int> repetitions;

  static empty() => SportExercise(uuidFromDB: null, title: 'Без названия', description: '1', exersizeType: SportExersizeType.empty, level: DificultyLevel.empty, duration: Duration.zero, repetitions: [0, 0],);

  @override
  List<Object?> get props => [
        uuid,
        title,
        description,
        exersizeType,
        level,
        duration,
        repetitions,
      ];
}