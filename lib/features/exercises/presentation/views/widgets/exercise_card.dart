import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/enums.dart';
import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';

Map<DificultyLevel, Color> levelColors = {
  DificultyLevel.empty: const Color.fromARGB(200, 158, 158, 158),
  DificultyLevel.beginner: const Color.fromARGB(199, 136, 216, 99),
  DificultyLevel.middle: const Color.fromARGB(198, 243, 235, 85),
  DificultyLevel.professional: const Color.fromARGB(198, 231, 96, 96),
};

Map<SportExersizeType, Icon> typeIcons = {
  SportExersizeType.empty: const Icon(Icons.hourglass_empty_rounded),
  SportExersizeType.cardio: const Icon(Icons.monitor_heart_rounded),
  SportExersizeType.strength: const Icon(Icons.fitness_center),
  SportExersizeType.stretch: const Icon(Icons.sports_gymnastics_rounded),
};

class ExerciseCard extends StatefulWidget {
  const ExerciseCard(this.exercise, {super.key});
  final SportExercise exercise;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Future<bool?> showConfirmationDialog(
      BuildContext context, String itemName, String uuid) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Удалить?'),
          content: Text(
            'Вы уверены, что хотите удалить "$itemName"?',
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              child: const Text(
                'Отмена',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ManageExerciseCubit>().deleteExercise(uuid);
                Navigator.of(ctx).pop(true);
              },
              child: const Text(
                'Удалить',
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
      color: levelColors[widget.exercise.level],
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
      shadowColor: const Color.fromARGB(171, 39, 29, 45),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                          text: widget.exercise.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      TextSpan(
                        text: '\n(${widget.exercise.level.toDisplay()})',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // TODO: Add edit exercise
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showConfirmationDialog(context, widget.exercise.title,
                            widget.exercise.uuid);
                      },
                    ),
                  ],
                )
              ],
            ),
            ExpansionTile(
              expandedAlignment: Alignment.topLeft,
              tilePadding: const EdgeInsets.all(0),
              leading: typeIcons[widget.exercise.exersizeType],
              title: Text(
                  widget.exercise.exersizeType.toDisplay() ?? 'Описание',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              children: [
                Text(widget.exercise.description),
                const SizedBox(
                  height: 7,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ExerciseDuration(widget.exercise.duration.inMinutes.toString()),
                ExerciseRepetitions(widget.exercise.repetitions),
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
        Text('$duration минут')
      ],
    );
  }
}

class ExerciseRepetitions extends StatelessWidget {
  const ExerciseRepetitions(this.repetitions, {super.key});
  final List<int> repetitions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.event_repeat_rounded),
        const SizedBox(
          width: 7,
        ),
        Text('${repetitions[0]} - ${repetitions[1]} повторений')
      ],
    );
  }
}
