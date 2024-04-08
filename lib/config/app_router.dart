import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: ManageExerciseRoute.page,
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          transitionsBuilder: TransitionsBuilders.slideRight,
          durationInMilliseconds: 0,
        ),
        CustomRoute(
          page: SportsExercisesRoute.page,
          initial: true,
          barrierColor: Colors.transparent,
          barrierDismissible: true,
          transitionsBuilder: TransitionsBuilders.slideRight,
          durationInMilliseconds: 0,
        ),
      ];
}
