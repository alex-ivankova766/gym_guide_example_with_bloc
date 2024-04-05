import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';
import '../widgets/exercise_card.dart';

class SportsExercisesScreen extends StatelessWidget {
  const SportsExercisesScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excercises')),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.white, child: const Icon(Icons.plus_one), onPressed: () {
        // TODO: go to edit screen
        context.read<ManageExerciseCubit>().addExercise(SportExercise.empty());
      },),
      body: BlocBuilder<ManageExerciseCubit, ManageExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is ExercisesLoaded) {
            return SingleChildScrollView(child: Column(children: state.exercises.map((e) => SizedBox(width: double.infinity, child: ExerciseCard(e))).toList(),));
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

}
