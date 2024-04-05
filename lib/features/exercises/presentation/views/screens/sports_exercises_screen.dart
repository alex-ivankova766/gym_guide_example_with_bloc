import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';

class SportsExercisesScreen extends StatelessWidget {
  const SportsExercisesScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excercises')),
      floatingActionButton: IconButton(icon: Icon(Icons.plus_one), onPressed: () {
        context.read<ManageExerciseCubit>().addExercise(SportExercise.empty);
      },),
      body: BlocBuilder<ManageExerciseCubit, ManageExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is ExercisesLoaded) {
            return Column(children: state.exercises.map((e) => Text(e.title)).toList(),);
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }

}
