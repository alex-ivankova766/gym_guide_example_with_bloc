
import '../../../../shared/domain/entities/sport_excercise.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/sport_exercises_repository.dart';

class GetExercises implements UseCase<List<SportExercise>, NoParams> {
  GetExercises(this.exerciseRepository);
  final SportExercisesRepository exerciseRepository;

  @override
  Future<List<SportExercise>> call(NoParams params) async {
    return exerciseRepository.getExercises();
  }
}