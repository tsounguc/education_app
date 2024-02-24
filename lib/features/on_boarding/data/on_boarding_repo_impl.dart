import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  const OnBoardingRepositoryImpl(this._localDataSource);
  final OnBoardingLocalDataSource _localDataSource;
  @override
  ResultVoid cacheFirstTimer() async {
    // TODO: implement cacheFirstTimer
    throw UnimplementedError();
  }

  @override
  ResultFuture<bool> isUserFirstTimer() async {
    // TODO: implement isUserFirstTimer
    throw UnimplementedError();
  }
}
