
import 'package:equatable/equatable.dart';

import '../../data/models/enums.dart';

class SportExercise extends Equatable {
  const SportExercise({
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

  static const empty = SportExercise(uuid: '1', title: '1', description: '1', exersizeType: SportExersizeType.empty, level: DificultyLevel.empty, duration: Duration.zero, repetitions: [0, 0],);

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