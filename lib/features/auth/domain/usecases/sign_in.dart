import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(
    SignInParams params,
  ) =>
      _repository.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
