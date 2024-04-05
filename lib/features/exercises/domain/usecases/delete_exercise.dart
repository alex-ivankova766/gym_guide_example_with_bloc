
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/sport_exercises_repository.dart';

class DeleteExercise implements UseCase<void, DeleteExerciseParams> {
  DeleteExercise(this.exerciseRepository);
  final SportExercisesRepository exerciseRepository;

  @override
  Future<void> call(DeleteExerciseParams params) async {
    return exerciseRepository.deleteExercise(params.uuid);
  }
}


class DeleteExerciseParams extends Params {
  DeleteExerciseParams({
    required this.uuid,
  });
  final String uuid;

  @override
  List<Object?> get props => [
        uuid
      ];
}