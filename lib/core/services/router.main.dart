part of 'package:education_app/core/services/router.dart';

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
            // get user info from firebase
            final user = serviceLocator<FirebaseAuth>().currentUser!;

            // create user model with user info
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
    case CourseDetailsScreen.id:
      return _pageBuilder(
        (_) => CourseDetailsScreen(settings.arguments! as Course),
        settings: settings,
      );
    // case '/forgot-password':
    //   return _pageBuilder(
    //     (_) => const fui.ForgotPasswordScreen(),
    //     settings: settings,
    //   );
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
