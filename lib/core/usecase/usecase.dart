import 'package:education_app/core/utils/typedefs.dart';

abstract class UseCase<T> {
  const UseCase();
  ResultFuture<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}
