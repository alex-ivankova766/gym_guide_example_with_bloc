import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'excercises_event.dart';
part 'excercises_state.dart';

class ExcercisesBloc extends Bloc<ExcercisesEvent, ExcercisesState> {
  ExcercisesBloc() : super(ExcercisesInitial()) {
    on<ExcercisesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
