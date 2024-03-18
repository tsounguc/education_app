import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';
import 'package:education_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:education_app/features/auth/domain/usecases/sign_in.dart';
import 'package:education_app/features/auth/domain/usecases/sign_up.dart';
import 'package:education_app/features/auth/domain/usecases/update_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required ForgotPassword forgotPassword,
    required UpdateUser updateUser,
  })  : _signIn = signIn,
        _signUp = signUp,
        _forgotPassword = forgotPassword,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<SignInEvent>(_signInWithEmailAndPasswordHandler);
    on<SignUpEvent>(_createUserAccountHandler);
    on<ForgotPasswordEvent>(_forgotPasswordHandler);
    on<UpdateUserEvent>(_updateUserHandler);
  }

  final SignIn _signIn;
  final SignUp _signUp;
  final ForgotPassword _forgotPassword;
  final UpdateUser _updateUser;

  Future<void> _signInWithEmailAndPasswordHandler(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signIn(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (user) => emit(SignedIn(user)),
    );
  }

  Future<void> _createUserAccountHandler(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (user) => emit(const SignedUp()),
    );
  }

  Future<void> _forgotPasswordHandler(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await _forgotPassword(event.email);

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (success) => emit(const ForgotPasswordSent()),
    );
  }

  Future<void> _updateUserHandler(
    UpdateUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _updateUser(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (success) => emit(const UserUpdated()),
    );
  }
}
