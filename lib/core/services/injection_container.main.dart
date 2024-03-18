part of 'injection_container.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: serviceLocator(),
        isUserFirstTimer: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(serviceLocator()))
    ..registerLazySingleton(() => IsUserFirstTimer(serviceLocator()))
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  serviceLocator
    ..registerFactory(
      () => AuthBloc(
        signIn: serviceLocator(),
        signUp: serviceLocator(),
        forgotPassword: serviceLocator(),
        updateUser: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => SignIn(serviceLocator()))
    ..registerLazySingleton(() => SignUp(serviceLocator()))
    ..registerLazySingleton(() => ForgotPassword(serviceLocator()))
    ..registerLazySingleton(() => UpdateUser(serviceLocator()))
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: serviceLocator(),
        cloudStoreClient: serviceLocator(),
        dbClient: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth)
    ..registerLazySingleton(() => FirebaseFirestore)
    ..registerLazySingleton(() => FirebaseStorage);
}
