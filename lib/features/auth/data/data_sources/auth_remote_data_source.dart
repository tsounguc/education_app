import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  AuthRemoteDataSource();
  Future<void> forgotPassword({required String email});

  Future<LocalUser> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
