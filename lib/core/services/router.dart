import 'package:education_app/core/common/screens/page_under_construction.dart';
import 'package:education_app/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case OnBoardingScreen.id:
      return _pageBuilder(
        (context) => const OnBoardingScreen(),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (context) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
