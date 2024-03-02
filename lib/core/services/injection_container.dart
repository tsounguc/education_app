import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:education_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/features/on_boarding/domain/usecases/is_user_first_timer.dart';
import 'package:education_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
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
