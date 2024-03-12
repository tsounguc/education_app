import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;
  @override
  ResultVoid forgotPassword({
    required String email,
  }) async {
    try {
      await _remoteDataSource.forgotPassword(email: email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
