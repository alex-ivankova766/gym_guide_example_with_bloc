import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_router.gr.dart';
import '../../../../../config/config.dart';
import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';
import '../widgets/exercise_card.dart';

@RoutePage()
class SportsExercisesScreen extends StatefulWidget {
  const SportsExercisesScreen({super.key});

  @override
  State<SportsExercisesScreen> createState() => _SportsExercisesScreenState();
}

class _SportsExercisesScreenState extends State<SportsExercisesScreen> {
  bool sortByType = false;
  bool sortByDifficulty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ResStrings.exercisesList),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'Sort by Type',
                child: ListTile(
                  title: const Text(ResStrings.sortByType),
                  onTap: () {
                    setState(() {
                      sortByType = !sortByType;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                value: 'Sort by Difficulty',
                child: ListTile(
                  title: const Text(ResStrings.sortByLevel),
                  onTap: () {
                    setState(() {
                      sortByDifficulty = !sortByDifficulty;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.plus_one),
        onPressed: () {
          SportExercise newExercise = SportExercise.empty();
          context.read<ManageExerciseCubit>().addExercise(newExercise);
          context.router.push(ManageExerciseRoute(uuid: newExercise.uuid));
        },
      ),
      body: BlocBuilder<ManageExerciseCubit, ManageExercisesState>(
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (state is ExercisesLoaded) {
            List<SportExercise> sortedExercises = state.exercises;
            if (sortByType) {
              sortedExercises.sort((a, b) => a.exersizeType.index.compareTo(b.exersizeType.index));
            }
            if (sortByDifficulty) {
              sortedExercises.sort((a, b) => a.level.index.compareTo(b.level.index));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  ...sortedExercises.map((e) => SizedBox(width: double.infinity, child: ExerciseCard(e))),
                ],
              ),
            );
          } else {
            return const Center(child: Text(ResStrings.wrong));
          }
        },
      ),
    );
  }
}
