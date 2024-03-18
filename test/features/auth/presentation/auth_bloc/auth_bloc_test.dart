import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';
import 'package:education_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:education_app/features/auth/domain/usecases/sign_in.dart';
import 'package:education_app/features/auth/domain/usecases/sign_up.dart';
import 'package:education_app/features/auth/domain/usecases/update_user.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc bloc;

  late SignInParams testSignInParams;
  late SignUpParams testSignUpParams;
  late UpdateUserParams testUpdateUserParams;

  late ServerFailure testServerFailure;
  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    bloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );

    testServerFailure = ServerFailure(
      message: 'message',
      statusCode: 500,
    );
  });

  setUpAll(() {
    testSignInParams = const SignInParams.empty();
    testSignUpParams = const SignUpParams.empty();
    testUpdateUserParams = const UpdateUserParams.empty();
    registerFallbackValue(testSignInParams);
    registerFallbackValue(testSignUpParams);
    registerFallbackValue(testUpdateUserParams);
  });

  tearDown(() => bloc.close());

  test(
      'given AuthBloc '
      'when bloc is instantiated '
      'then initial state should be [AuthInitial] ', () async {
    // Arrange
    // Act
    // Assert
    expect(bloc.state, const AuthInitial());
  });
  const testUser = LocalUser.empty();

  group('signIn - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signIn] is called '
      'and completed successfully '
      'then emit [AuthLoading, SignedIn]',
      build: () {
        when(
          () => signIn(any()),
        ).thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: testSignInParams.email,
          password: testSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedIn(testUser),
      ],
      verify: (bloc) {
        verify(() => signIn(testSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signIn] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => signIn(any()),
        ).thenAnswer((_) async => Left(testServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: testSignInParams.email,
          password: testSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testServerFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => signIn(testSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('signUp - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signUp] is called '
      'and completed successfully '
      'then emit [AuthLoading, SignedUp]',
      build: () {
        when(
          () => signUp(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: testSignUpParams.email,
          password: testSignUpParams.password,
          fullName: testSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedUp(),
      ],
      verify: (bloc) {
        verify(() => signUp(testSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signUp] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => signUp(any()),
        ).thenAnswer((_) async => Left(testServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: testSignUpParams.email,
          password: testSignUpParams.password,
          fullName: testSignUpParams.fullName,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testServerFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => signUp(testSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('forgotPassword - ', () {
    const testEmail = 'testemail@gmail.com';
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.forgotPassword] is called '
      'and completed successfully '
      'then emit [AuthLoading, ForgotPasswordSent]',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          email: testEmail,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (bloc) {
        verify(() => forgotPassword(testEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.forgotPassword] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => Left(testServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          email: testEmail,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testServerFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => forgotPassword(testEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('updateUser - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.updateUser] is called '
      'and completed successfully '
      'then emit [AuthLoading, UserUpdated]',
      build: () {
        when(
          () => updateUser(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: testUpdateUserParams.action,
          userData: testUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
      ],
      verify: (bloc) {
        verify(() => updateUser(testUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.updateUser] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => updateUser(any()),
        ).thenAnswer((_) async => Left(testServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: testUpdateUserParams.action,
          userData: testUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testServerFailure.errorMessage),
      ],
      verify: (bloc) {
        verify(() => updateUser(testUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}
