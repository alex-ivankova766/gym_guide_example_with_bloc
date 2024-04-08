import 'package:gym_guide/shared/data/models/sport_exercise_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../shared/domain/entities/sport_excercise.dart';

abstract class LocalExercisesDatasource {
  Future<List<SportExercise>> getExercises();
  Future<void> addExercise(SportExercise exercise);
  Future<void> editExercise(SportExercise exercise);
  Future<void> deleteExercise(String uuid);
}

class LocalExercisesDatasourceImpl extends LocalExercisesDatasource {
  final Future<Database> _database;

  LocalExercisesDatasourceImpl() : _database = _initDatabase();

  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'exercises_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE exercises(id INTEGER PRIMARY KEY, uuid TEXT, title TEXT, description TEXT, exersizeType TEXT, level TEXT, duration INTEGER, repetitions TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<void> addExercise(SportExercise exercise) async {
    final Database db = await _database;
    await db.insert(
      'exercises',
      SportExerciseModel.fromEntity(exercise).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> editExercise(SportExercise exercise) async {
    final Database db = await _database;
    await db.update(
      'exercises',
      SportExerciseModel.fromEntity(exercise).toJson(),
      where: 'uuid = ?',
      whereArgs: [exercise.uuid],
    );
  }

  @override
  Future<List<SportExercise>> getExercises() async {
    final Database db = await _database;
    final List<Map<String, dynamic>> maps = await db.query('exercises');
    return List.generate(maps.length, (i) {
      return SportExerciseModel.fromJson(maps[i]).toEntity();
    });
  }

  @override
  Future<void> deleteExercise(String uuid) async {
    final Database db = await _database;
    await db.delete(
      'exercises',
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
  }
}
