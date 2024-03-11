import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repository);
  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) => _repository.forgotPassword(email: params);
}
