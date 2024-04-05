
import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/sport_exercises_repository.dart';

class AddExercise implements UseCase<void, AddExerciseParams> {
  AddExercise(this.exerciseRepository);
  final SportExercisesRepository exerciseRepository;

  @override
  Future<void> call(AddExerciseParams params) async {
    return exerciseRepository.addExercise(params.exercise);
  }
}


class AddExerciseParams extends Params {
  AddExerciseParams({
    required this.exercise,
  });
  final SportExercise exercise;

  @override
  List<Object?> get props => [
        exercise
      ];
}