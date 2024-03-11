import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repository);
  final AuthRepository _repository;

  @override
  ResultVoid call(SignUpParams params) {
    return _repository.signUp(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  final String email;
  final String password;
  final String fullName;
  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
      ];
}
