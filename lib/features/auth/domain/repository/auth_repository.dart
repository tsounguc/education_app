import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();
  ResultVoid forgotPassword({required String email});

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultVoid signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultVoid updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
