import 'package:education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepository {
  ResultVoid cacheFirstTimer();
  ResultFuture<bool> isUserFirstTimer();
}
