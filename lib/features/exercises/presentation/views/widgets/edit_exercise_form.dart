import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_router.gr.dart';
import '../../../../../config/config.dart';
import '../../../../../shared/domain/entities/enums.dart';
import '../../../../../shared/domain/entities/sport_excercise.dart';
import '../../bloc/manage_exercise_cubit.dart';
import 'exercise_card.dart';

TextStyle labelFormStyle(context) => TextStyle(
    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
    color: Theme.of(context).textTheme.bodyLarge?.color);
TextStyle labelStyle(context) => TextStyle(
    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
    color: Theme.of(context).textTheme.bodyMedium?.color);

class EditExerciseForm extends StatefulWidget {
  const EditExerciseForm({required this.exercise, super.key});
  final SportExercise exercise;

  @override
  State<EditExerciseForm> createState() => _EditExerciseFormState();
}

class _EditExerciseFormState extends State<EditExerciseForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationController;
  late TextEditingController _repetitionsFromController;
  late TextEditingController _repetitionsToController;
  SportExersizeType? _selectedType;
  DificultyLevel? _selectedLevel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.exercise.title);
    _descriptionController =
        TextEditingController(text: widget.exercise.description);
    _durationController = TextEditingController(
        text: widget.exercise.duration.inMinutes.toString());
    _repetitionsFromController = TextEditingController(
        text: widget.exercise.repetitions.from.toString());
    _repetitionsToController =
        TextEditingController(text: widget.exercise.repetitions.to.toString());
    _selectedType = widget.exercise.exersizeType;
    _selectedLevel = widget.exercise.level;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                onTap: () {
                  _titleController.clear();
                },
                decoration: InputDecoration(
                  labelText: ResStrings.title,
                  labelStyle: labelFormStyle(context),
                ),
              ),
              TextField(
                controller: _descriptionController,
                onTap: () {
                  _descriptionController.clear();
                },
                decoration: InputDecoration(
                  labelText: ResStrings.description,
                  labelStyle: labelFormStyle(context),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ResStrings.exerciseType,
                style: labelStyle(context),
              ),
              Wrap(
                spacing: 8.0,
                children: SportExersizeType.values.map((type) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<SportExersizeType>(
                        value: type,
                        groupValue: _selectedType,
                        onChanged: (SportExersizeType? value) {
                          setState(() {
                            _selectedType = value;
                          });
                        },
                      ),
                      TYPE_ICONS[type] ?? const SizedBox(),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ResStrings.dificultyLevel,
                style: labelStyle(context),
              ),
              DropdownButton<DificultyLevel>(
                value: _selectedLevel,
                onChanged: (DificultyLevel? value) {
                  setState(() {
                    _selectedLevel = value;
                  });
                },
                items: DificultyLevel.values.map((level) {
                  return DropdownMenuItem<DificultyLevel>(
                    value: level,
                    child: Container(
                      color: LEVEL_COLORS[level] ?? Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(level.toDisplay() ?? ''),
                      ),
                    ),
                  );
                }).toList(),
              ),
              TextField(
                controller: _durationController,
                onTap: () {
                  _durationController.clear();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: ResStrings.durationMinutes,
                  labelStyle: labelFormStyle(context),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ResStrings.repititions,
                style: labelStyle(context),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _repetitionsFromController,
                      onTap: () {
                        _repetitionsFromController.clear();
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'От',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ResStrings.repetitionsNull;
                        }
                        if (int.tryParse(value) == null) {
                          return ResStrings.repetitionsString;
                        }
                        if (int.tryParse(value) != null &&
                            int.tryParse(_repetitionsToController.text) !=
                                null &&
                            int.tryParse(value)! <
                                int.tryParse(
                                    _repetitionsFromController.text)!) {
                          return ResStrings.toLessThanFrom;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: _repetitionsToController,
                      onTap: () {
                        _repetitionsToController.clear();
                      },
                      decoration: const InputDecoration(
                        labelText: ResStrings.to,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ResStrings.repetitionsNull;
                        }
                        if (int.tryParse(value) == null) {
                          return ResStrings.repetitionsString;
                        }
                        if (int.tryParse(value) != null &&
                            int.tryParse(_repetitionsToController.text) !=
                                null &&
                            int.tryParse(value)! <
                                int.tryParse(
                                    _repetitionsFromController.text)!) {
                          return ResStrings.toLessThanFrom;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    print('!validate');
                    return;
                  }
                  final updatedExercise = SportExercise(
                    uuidFromDB: widget.exercise.uuid,
                    exersizeType: _selectedType ?? SportExersizeType.empty,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    duration:
                        Duration(minutes: int.parse(_durationController.text)),
                    repetitions: Repetitions(
                        from:
                            int.tryParse(_repetitionsFromController.text) ?? 1,
                        to: int.tryParse(_repetitionsToController.text) ?? 1),
                    level: _selectedLevel ?? DificultyLevel.empty,
                  );
                  context
                      .read<ManageExerciseCubit>()
                      .editExercise(updatedExercise);
                  context.router.push(const SportsExercisesRoute());
                },
                child: const Text(ResStrings.save),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _repetitionsFromController.dispose();
    _repetitionsToController.dispose();
    super.dispose();
  }
}
