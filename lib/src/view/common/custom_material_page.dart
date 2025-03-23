import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTransitionPageBuilder extends CustomTransitionPage<void> {
  /// Creates a [CustomTransitionPageBuilder].
  CustomTransitionPageBuilder({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 20),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
