import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/common/screens/page_under_construction.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:education_app/features/auth/presentation/views/sign_in_screen.dart';
import 'package:education_app/features/auth/presentation/views/sign_up_screen.dart';
import 'package:education_app/features/dashboard/presentation/views/dashboard.dart';
import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:education_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/features/on_boarding/presentation/views/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final arguments = settings.arguments;
  switch (settings.name) {
    case '/':
      final prefs = serviceLocator<SharedPreferences>();
      return _pageBuilder(
        (context) {
          // if (prefs.getBool(kFirstTimerKey) ?? true) {
          //   return BlocProvider(
          //     create: (_) => serviceLocator<OnBoardingCubit>(),
          //     child: const OnBoardingScreen(),
          //   );
          // } else
          if (serviceLocator<FirebaseAuth>().currentUser != null) {
            final user = serviceLocator<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const Dashboard();
          } else {
            return BlocProvider(
              create: (_) => serviceLocator<AuthBloc>(),
              child: const SignInScreen(),
            );
          }
        },
        settings: settings,
      );
    case SignInScreen.id:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.id:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case Dashboard.id:
      return _pageBuilder(
        (_) => const Dashboard(),
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
