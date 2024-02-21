import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';

class CacheFirstTimer extends UseCase<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultVoid call() async => _repository.cacheFirstTimer();
}
