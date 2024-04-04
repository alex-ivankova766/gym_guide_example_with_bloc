import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'excercises_state.dart';

class ExcercisesCubit extends Cubit<ExcercisesState> {
  ExcercisesCubit() : super(ExcercisesInitial());
}
