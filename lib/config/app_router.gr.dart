// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:gym_guide/features/exercises/presentation/views/screens/manage_exercises_screen.dart'
    as _i1;
import 'package:gym_guide/features/exercises/presentation/views/screens/sports_exercises_screen.dart'
    as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ManageExerciseRoute.name: (routeData) {
      final args = routeData.argsAs<ManageExerciseRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ManageExerciseScreen(
          args.uuid,
          key: args.key,
        ),
      );
    },
    SportsExercisesRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.SportsExercisesScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ManageExerciseScreen]
class ManageExerciseRoute extends _i3.PageRouteInfo<ManageExerciseRouteArgs> {
  ManageExerciseRoute({
    required String? uuid,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ManageExerciseRoute.name,
          args: ManageExerciseRouteArgs(
            uuid: uuid,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageExerciseRoute';

  static const _i3.PageInfo<ManageExerciseRouteArgs> page =
      _i3.PageInfo<ManageExerciseRouteArgs>(name);
}

class ManageExerciseRouteArgs {
  const ManageExerciseRouteArgs({
    required this.uuid,
    this.key,
  });

  final String? uuid;

  final _i4.Key? key;

  @override
  String toString() {
    return 'ManageExerciseRouteArgs{uuid: $uuid, key: $key}';
  }
}

/// generated route for
/// [_i2.SportsExercisesScreen]
class SportsExercisesRoute extends _i3.PageRouteInfo<void> {
  const SportsExercisesRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SportsExercisesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SportsExercisesRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
