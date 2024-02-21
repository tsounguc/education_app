import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';

class IsUserFirstTimer extends UseCase<bool> {
  IsUserFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.isUserFirstTimer();
}
