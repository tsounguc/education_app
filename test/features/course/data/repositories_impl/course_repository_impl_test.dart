import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/features/course/data/models/course_model.dart';
import 'package:education_app/features/course/data/repositories_impl/course_repository_impl.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/domain/repositories/course_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSource extends Mock implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late CourseRepositoryImpl repositoryImpl;
  late ServerException testServerException;
  final testCourse = CourseModel.empty();
  final testCourses = [testCourse];
  setUp(() {
    remoteDataSource = MockCourseRemoteDataSource();
    repositoryImpl = CourseRepositoryImpl(remoteDataSource);
    testServerException = const ServerException(
      message: 'message',
      statusCode: 'statusCode',
    );
    registerFallbackValue(testCourse);
  });

  test(
    'given CourseRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [CourseRepository]',
    () {
      expect(repositoryImpl, isA<CourseRepository>());
    },
  );

  group('getCourses', () {
    test(
      'given CourseRepositoryImpl, '
      'when [CourseRepositoryImpl.getCourses] is called '
      'then complete call to remote data source successfully '
      'and return a [List<Course>]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getCourses(),
        ).thenAnswer(
          (_) async => testCourses,
        );
        // Act
        final result = await repositoryImpl.getCourses();
        // Assert
        expect(
          result,
          equals(
            Right<Failure, List<Course>>(
              testCourses,
            ),
          ),
        );
        verify(
          () => remoteDataSource.getCourses(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given CourseRepositoryImpl, '
      'when [CourseRepositoryImpl.getCourses] is called '
      'and remote data source call is unsuccessful '
      'then return [ServerFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getCourses(),
        ).thenThrow(testServerException);
        // Act
        final result = await repositoryImpl.getCourses();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, List<Course>>(
              ServerFailure.fromException(testServerException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.getCourses(),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('addCourse', () {
    test(
      'given CourseRepositoryImpl, '
      'when [CourseRepositoryImpl.addCourse] is called '
      'then complete call to remote data source successfully '
      'and return a [Course]',
      () async {
        // Arrange
        when(
          () => remoteDataSource.addCourse(any()),
        ).thenAnswer(
          (_) async => Future.value(),
        );
        // Act
        final result = await repositoryImpl.addCourse(course: testCourse);
        // Assert
        expect(
          result,
          equals(
            const Right<Failure, void>(null),
          ),
        );
        verify(() => remoteDataSource.addCourse(testCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'given CourseRepositoryImpl, '
      'when [CourseRepositoryImpl.addCourse] is called '
      'and remote data source call is unsuccessful '
      'then return [ServerFailure] ',
      () async {
        // Arrange
        when(
          () => remoteDataSource.addCourse(any()),
        ).thenThrow(testServerException);
        // Act
        final result = await repositoryImpl.addCourse(course: testCourse);
        // Assert
        expect(
          result,
          equals(
            Left<Failure, void>(
              ServerFailure.fromException(testServerException),
            ),
          ),
        );
        verify(
          () => remoteDataSource.addCourse(testCourse),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
