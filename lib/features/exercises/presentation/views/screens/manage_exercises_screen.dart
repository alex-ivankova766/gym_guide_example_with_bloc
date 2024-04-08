import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_guide/config/app_router.gr.dart';

import '../../../../../config/config.dart';
import '../../bloc/manage_exercise_cubit.dart';
import '../widgets/edit_exercise_form.dart';

@RoutePage()
class ManageExerciseScreen extends StatelessWidget {
  const ManageExerciseScreen(this.uuid, {super.key});
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(ResStrings.manageExercise),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.push(const SportsExercisesRoute());
          },
        ),
      ),
      body: BlocBuilder<ManageExerciseCubit, ManageExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          }
          if (state is ExercisesLoaded) {
            return EditExerciseForm(exercise: state.exercises.firstWhere((element) => element.uuid == uuid));
          } else {
            return const Center(child: Text(ResStrings.wrong));
          }
        },
      ),
      
    );
  }
}
