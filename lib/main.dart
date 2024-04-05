

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/exercises/data/datasources/local_exercises_datasource.dart';
import 'features/exercises/data/datasources/mock_excercises_datasource.dart';
import 'features/exercises/data/repositories/sport_exercises_repository_impl.dart';
import 'features/exercises/domain/usecases/usecases.dart';
import 'features/exercises/presentation/bloc/manage_exercise_cubit.dart';
import 'features/exercises/presentation/views/screens/sports_exercises_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider<SportExercisesRepositoryImpl>(
          create: (ctx) => SportExercisesRepositoryImpl(
            LocalExercisesDatasourceImpl(),
            MockExersisesDatasourceImpl(),
          ),
        )]
      ,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ManageExerciseCubit>(
            create: (ctx) => ManageExerciseCubit(
                addExercise: AddExercise(ctx.read<SportExercisesRepositoryImpl>()),
                editExercise: EditExercise(ctx.read<SportExercisesRepositoryImpl>()),
                getExercises: GetExercises(ctx.read<SportExercisesRepositoryImpl>()),
                deleteExercise: DeleteExercise(ctx.read<SportExercisesRepositoryImpl>())),
          ),],
        child: Builder(
          builder: (context) {
            return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gym Guide",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
              create: (context) => ManageExerciseCubit(
                    addExercise: AddExercise(context.read<SportExercisesRepositoryImpl>()),
                editExercise: EditExercise(context.read<SportExercisesRepositoryImpl>()),
                getExercises: GetExercises(context.read<SportExercisesRepositoryImpl>()),
                deleteExercise: DeleteExercise(context.read<SportExercisesRepositoryImpl>())
                  ),
              child: const SportsExercisesScreen());
  }
}
