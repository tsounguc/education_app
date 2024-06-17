import 'package:education_app/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/features/course/data/models/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mocktail/mocktail.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
//
// class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;
  setUp(() async {
    firestore = FakeFirebaseFirestore();
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    storage = MockFirebaseStorage();

    remoteDataSource = CourseRemoteDataSourceImpl(firestore, storage, auth);
  });

  group('addCourse', () {
    test(
      'given CourseRemoteDataSourceImpl '
      'when [CourseRemoteDataSourceImpl.addCourse] is called '
      'then add the given course to the firestore collection ',
      () async {
        // Arrange
        final testCourse = CourseModel.empty();

        // Act
        await remoteDataSource.addCourse(
          testCourse,
        );

        // Assert
        final firestoreData = await firestore.collection('courses').get();
        expect(firestoreData.docs.length, 1);

        final courseReference = firestoreData.docs.first;
        expect(courseReference.data()['id'], courseReference.id);

        final groupData = await firestore.collection('groups').get();
        expect(groupData.docs.length, 1);

        final groupReference = groupData.docs.first;
        expect(groupReference.data()['id'], groupReference.id);

        expect(courseReference.data()['groupId'], groupReference.id);
        expect(groupReference.data()['courseId'], courseReference.id);
      },
    );
  });

  group('getCourses', () {
    test(
      'given CourseRemoteDataSourceImpl '
      'when [CourseRemoteDataSourceImpl.getCourse] is called '
      'then return a List<Course> ',
      () async {
        // Arrange
        final firstDate = DateTime.now();
        final secondDate = DateTime.now().add(const Duration(seconds: 20));
        final expectedCourses = [
          CourseModel.empty().copyWith(createdAt: firstDate),
          CourseModel.empty().copyWith(
            createdAt: secondDate,
            id: '1',
            title: 'Course 1',
          ),
        ];

        for (final course in expectedCourses) {
          await firestore.collection('courses').add(course.toMap());
        }

        // Act
        final result = await remoteDataSource.getCourses();

        // Assert
        expect(result, expectedCourses);
      },
    );
  });
}
