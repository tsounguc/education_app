import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource remoteDataSource;
  late UserCredential userCredential;
  late DocumentReference<DataMap> documentReference;
  late MockUser mockUser;

  const testUser = LocalUserModel.empty();

  setUpAll(() async {
    // instantiate Firebase Auth client
    authClient = MockFirebaseAuth();

    // instantiate FireStore client
    cloudStoreClient = FakeFirebaseFirestore();

    // instantiate FireBaseStorage client
    dbClient = MockFirebaseStorage();

    // get users collection and get document reference id
    documentReference = cloudStoreClient.collection('users').doc();

    // add a user in document
    await documentReference.set(
      testUser.copyWith(uid: documentReference.id).toMap(),
    );

    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    remoteDataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );

    when(() => authClient.currentUser).thenAnswer((_) => mockUser);
  });

  const tPassword = 'Test Password';
  const tFullName = 'Test FullName';
  const tEmail = 'testemail@mail.org';

  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message: 'There is no user record corresponding to this identifier.',
  );

  group('forgotPassword - ', () {
    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.forgotPassword] is called '
        'and no [Exception] is thrown '
        'then complete successfully ', () async {
      when(() => authClient.sendPasswordResetEmail(email: any(named: 'email')))
          .thenAnswer((invocation) async => Future.value());

      final methodCall = remoteDataSource.forgotPassword(email: tEmail);
      expect(methodCall, completes);
      verify(
        () => authClient.sendPasswordResetEmail(
          email: any(named: 'email'),
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.forgotPassword] is called '
        'and [FirebaseAuthException] is thrown '
        'then throw [ServerException] ', () async {
      when(() => authClient.sendPasswordResetEmail(email: any(named: 'email')))
          .thenThrow((invocation) async => tFirebaseAuthException);

      final methodCall = remoteDataSource.forgotPassword;

      expect(
        () => methodCall(email: tEmail),
        throwsA(isA<ServerException>()),
      );

      verify(
        () => authClient.sendPasswordResetEmail(
          email: any(named: 'email'),
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('signIn - ', () {
    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.signIn] is called '
        'and no [Exception] is thrown '
        'then return a [LocalUser] ', () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);

      final result = await remoteDataSource.signIn(
        email: tEmail,
        password: tPassword,
      );
      expect(result.uid, userCredential.user!.uid);
      expect(result.points, 0);
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.signIn] is called '
        'and [FirebaseAuthException] is thrown '
        'then throw [ServerException] ', () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow((invocation) async => tFirebaseAuthException);

      final methodCall = remoteDataSource.signIn;

      expect(
        () => methodCall(
          email: tEmail,
          password: tPassword,
        ),
        throwsA(isA<ServerException>()),
      );

      verify(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });

  group('signUp - ', () {
    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.signUp] is called '
        'and no [Exception] is thrown '
        'then complete successfully ', () async {
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      when(
        () => userCredential.user?.updateDisplayName(any()),
      ).thenAnswer((_) async => Future.value());

      when(
        () => userCredential.user?.updatePhotoURL(any()),
      ).thenAnswer((_) async => Future.value());

      final result = remoteDataSource.signUp(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      );

      expect(result, completes);

      await untilCalled(
        () => userCredential.user?.updatePhotoURL(any()),
      );

      await untilCalled(
        () => userCredential.user?.updateDisplayName(any()),
      );

      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verify(
        () => userCredential.user?.updateDisplayName(tFullName),
      ).called(1);

      verify(
        () => userCredential.user?.updatePhotoURL(kDefaultAvatar),
      ).called(1);

      // verifyNoMoreInteractions(authClient);
    });

    test(
      'given AuthRemoteDataSourceImpl '
      'when [AuthRemoteDataSourceImpl.signUp] is called '
      'and [FirebaseAuthException] is thrown '
      'then throw [ServerException] ',
      () async {
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);

        final methodCall = remoteDataSource.signUp;

        expect(
          () async => methodCall(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );
  });

  group('updateUser - ', () {
    setUp(() {
      mockUser = MockUser()..uid = documentReference.id;
      // when(() => authClient.currentUser).thenAnswer((_) => mockUser);
      registerFallbackValue(MockAuthCredential());
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.updateUser] is called '
        'and action is [UpdateUserAction.email] '
        'then update user email and complete successfully ', () async {
      when(
        () => mockUser.verifyBeforeUpdateEmail(
          any(),
        ),
      ).thenAnswer((_) async => Future.value());

      await remoteDataSource.updateUser(
        action: UpdateUserAction.email,
        userData: tEmail,
      );

      verify(() => mockUser.verifyBeforeUpdateEmail(tEmail)).called(1);

      verifyNever(() => mockUser.updatePhotoURL(any()));
      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.updatePassword(any()));

      final userData = await cloudStoreClient
          .collection('users')
          .doc(
            documentReference.id,
          )
          .get();

      expect(userData.data()?['email'], tEmail);
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.updateUser] is called '
        'and action is [UpdateUserAction.displayName] '
        'then update user displayName and complete successfully ', () async {
      when(
        () => mockUser.updateDisplayName(
          any(),
        ),
      ).thenAnswer((_) async => Future.value());

      await remoteDataSource.updateUser(
        action: UpdateUserAction.displayName,
        userData: tFullName,
      );

      verify(() => mockUser.updateDisplayName(tFullName)).called(1);

      verifyNever(() => mockUser.updatePhotoURL(any()));
      verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
      verifyNever(() => mockUser.updatePassword(any()));

      final userData = await cloudStoreClient
          .collection('users')
          .doc(
            documentReference.id,
          )
          .get();

      expect(userData.data()!['fullName'], tFullName);
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.updateUser] is called '
        'and action is [UpdateUserAction.bio] '
        'then update user bio and complete successfully ', () async {
      const newBio = 'new bio';

      await remoteDataSource.updateUser(
        action: UpdateUserAction.bio,
        userData: newBio,
      );
      final userData = await cloudStoreClient
          .collection('users')
          .doc(
            documentReference.id,
          )
          .get();

      expect(userData.data()!['bio'], newBio);

      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.updatePhotoURL(any()));
      verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
      verifyNever(() => mockUser.updatePassword(any()));
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.updateUser] is called '
        'and action is [UpdateUserAction.password] '
        'then update user password and complete successfully ', () async {
      when(
        () => mockUser.updatePassword(
          any(),
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        () => mockUser.reauthenticateWithCredential(any()),
      ).thenAnswer((_) async => userCredential);

      when(() => mockUser.email).thenReturn(tEmail);

      await remoteDataSource.updateUser(
        action: UpdateUserAction.password,
        userData: jsonEncode({
          'oldPassword': 'oldPassword',
          'newPassword': tPassword,
        }),
      );

      verify(() => mockUser.updatePassword(tPassword)).called(1);

      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.updatePhotoURL(any()));
      verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));

      final userData = await cloudStoreClient
          .collection('users')
          .doc(
            documentReference.id,
          )
          .get();

      expect(userData.data()!['password'], null);
    });

    test(
        'given AuthRemoteDataSourceImpl '
        'when [AuthRemoteDataSourceImpl.updateUser] is called '
        'and action is [UpdateUserAction.profilePic] '
        'then update user profilePic and complete successfully ', () async {
      final newProfilePic = File('assets/images/onBoarding_background.png');

      when(
        () => mockUser.updatePhotoURL(
          any(),
        ),
      ).thenAnswer((_) async => Future.value());

      await remoteDataSource.updateUser(
        action: UpdateUserAction.profilePic,
        userData: newProfilePic,
      );

      verify(() => mockUser.updatePhotoURL(any())).called(1);

      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.updatePassword(any()));
      verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));

      expect(dbClient.storedFilesMap.isNotEmpty, isTrue);
    });
  });
}
