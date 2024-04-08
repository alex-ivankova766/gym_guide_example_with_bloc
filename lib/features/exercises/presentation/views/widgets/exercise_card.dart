// ignore_for_file: constant_identifier_names

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_guide/config/app_router.gr.dart';

import '../../../../../config/config.dart';
import '../../../../../shared/domain/entities/enums.dart';
import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';

const Map<DificultyLevel, Color> LEVEL_COLORS = {
  DificultyLevel.empty: Color.fromARGB(200, 158, 158, 158),
  DificultyLevel.beginner: Color.fromARGB(199, 136, 216, 99),
  DificultyLevel.middle: Color.fromARGB(198, 243, 235, 85),
  DificultyLevel.professional: Color.fromARGB(198, 231, 96, 96),
};

const Map<SportExersizeType, Icon> TYPE_ICONS = {
  SportExersizeType.empty: Icon(Icons.hourglass_empty_rounded),
  SportExersizeType.cardio: Icon(Icons.monitor_heart_rounded),
  SportExersizeType.strength: Icon(Icons.fitness_center),
  SportExersizeType.stretch: Icon(Icons.sports_gymnastics_rounded),
};

class ExerciseCard extends StatelessWidget {
  const ExerciseCard(this.exercise, {super.key});
  final SportExercise exercise;

  // Подтверждение удаления
  Future<bool?> _showConfirmationDialog(
      BuildContext context, String itemName, String uuid) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Удалить?'),
          content: Text(
            '${ResStrings.sureDelete} "$itemName"?',
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text(
                ResStrings.cancel,
                style: TextStyle(color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ManageExerciseCubit>().deleteExercise(uuid);
                Navigator.of(ctx).pop(true);
              },
              child: const Text(
                ResStrings.delete,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LEVEL_COLORS[exercise.level],
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      shadowColor: const Color.fromARGB(171, 39, 29, 45),
      child: Container(
        padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: 
                ExpansionTile(
                  trailing: const Icon(Icons.menu, color: Colors.black,),
              expandedAlignment: Alignment.topLeft,
              tilePadding: const EdgeInsets.all(0),
              title: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                          text: exercise.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      TextSpan(
                        text: '\n(${exercise.level.toDisplay()})',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              children: [
                Text(exercise.description),
                const SizedBox(
                  height: 7,
                ),
              ],
            ),),
            const SizedBox(width: 12,),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.router.push(ManageExerciseRoute(uuid: exercise.uuid));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showConfirmationDialog(context, exercise.title,
                            exercise.uuid);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Row(children: [TYPE_ICONS[exercise.exersizeType] ?? const SizedBox(),
            Text(
                  exercise.exersizeType.toDisplay() ?? ResStrings.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),]),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExerciseDuration(exercise.duration.inMinutes.toString()),
                ExerciseRepetitions(exercise.repetitions),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDuration extends StatelessWidget {
  const ExerciseDuration(this.duration, {super.key});
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.timelapse_rounded),
        const SizedBox(
          width: 7,
        ),
        Text('$duration ${ResStrings.minutes}')
      ],
    );
  }
}

class ExerciseRepetitions extends StatelessWidget {
  const ExerciseRepetitions(this.repetitions, {super.key});
  final Repetitions repetitions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.event_repeat_rounded),
        const SizedBox(
          width: 7,
        ),
        Text('${repetitions.from} - ${repetitions.to} ${ResStrings.repititionsCount}')
      ],
    );
  }
}
