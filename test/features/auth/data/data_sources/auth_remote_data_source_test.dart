import 'package:education_app/core/enums/update_user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:education_app/features/auth/data/data_sources/auth_remote_data_source.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource remoteDataSource;
  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();

    // Mock sign in with Google.
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in.
    final mockUser = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    authClient = MockFirebaseAuth(mockUser: mockUser);
    final result = await authClient.signInWithCredential(credential);
    final user = result.user;

    dbClient = MockFirebaseStorage();

    remoteDataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  const tPassword = 'Test Password';
  const tFullName = 'Test UserName';
  const tEmail = 'testemail@mail.org';

  test('signUp - ', () async {
    // Arrange
    // Act
    await remoteDataSource.signUp(
      email: tEmail,
      fullName: tFullName,
      password: tPassword,
    );
    // Assert
    // expect that the user was created in the firestore and
    // the authClient also has this user
    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.displayName, tFullName);

    final user = await cloudStoreClient
        .collection('users')
        .doc(
          authClient.currentUser!.uid,
        )
        .get();
    expect(user.exists, isTrue);
  });

  test('signIn - ', () async {
    // Arrange
    await remoteDataSource.signUp(
      email: 'newEmail@mail.com',
      fullName: tFullName,
      password: tPassword,
    );
    await authClient.signOut();
    // Act
    await remoteDataSource.signIn(
      email: 'newEmail@mail.com',
      password: tPassword,
    );
    // Assert
    expect(authClient.currentUser, isNotNull);
    expect(
      authClient.currentUser!.email,
      equals('newEmail@mail.com'),
    );
  });

  group('updateUser - ', () {
    test('displayName', () async {
      // Arrange
      await remoteDataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );

      // Act
      await remoteDataSource.updateUser(
        action: UpdateUserAction.displayName,
        userData: 'new name',
      );

      // Assert
      expect(authClient.currentUser!.displayName, 'new name');
    });
  });
}
