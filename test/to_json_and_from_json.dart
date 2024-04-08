import 'package:flutter_test/flutter_test.dart';
import 'package:gym_guide/shared/data/models/sport_exercise_model.dart';
import 'package:gym_guide/shared/domain/entities/enums.dart';

void main() {
  group('SportExerciseModel', () {
    test('fromJson() should parse JSON correctly', () {

      Map<String, dynamic> json = {
        'uuid': '1',
        'title': 'Exercise Title',
        'description': 'Exercise Description',
        'exersizeType': 'cardio',
        'level': 'beginner',
        'duration': 30,
        'repetitions': [5, 10],
      };

      SportExerciseModel exerciseModel = SportExerciseModel.fromJson(json);

      expect(exerciseModel.uuid, '1');
      expect(exerciseModel.title, 'Exercise Title');
      expect(exerciseModel.description, 'Exercise Description');
      expect(exerciseModel.exersizeType, SportExersizeType.cardio);
      expect(exerciseModel.level, DificultyLevel.beginner);
      expect(exerciseModel.duration, const Duration(minutes: 30));
      expect(exerciseModel.repetitions, [5, 10]);
    });

    test('toJson() should serialize object to JSON correctly', () {

      SportExerciseModel exerciseModel = const SportExerciseModel(
        uuid: '1',
        title: 'Exercise Title',
        description: 'Exercise Description',
        exersizeType: SportExersizeType.cardio,
        level: DificultyLevel.beginner,
        duration: Duration(minutes: 30),
        repetitions: [5, 10],
      );

      Map<String, dynamic> json = exerciseModel.toJson();

      expect(json['uuid'], '1');
      expect(json['title'], 'Exercise Title');
      expect(json['description'], 'Exercise Description');
      expect(json['exersizeType'], 'cardio');
      expect(json['level'], 'beginner');
      expect(json['duration'], 30);
      expect(json['repetitions'], [5, 10]);
    });
  });
}
