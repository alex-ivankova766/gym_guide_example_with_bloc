
import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/sport_exercises_repository.dart';

class EditExercise implements UseCase<void, EditExerciseParams> {
  EditExercise(this.exerciseRepository);
  final SportExercisesRepository exerciseRepository;

  @override
  Future<void> call(EditExerciseParams params) async {
    return exerciseRepository.editExercise(params.exercise);
  }
}


class EditExerciseParams extends Params {
  EditExerciseParams({
    required this.exercise,
  });
  final SportExercise exercise;

  @override
  List<Object?> get props => [
        exercise
      ];
}