import 'package:dartz/dartz.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/features/course/domain/usescases/add_course.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repository.mock.dart';

void main() {
  late CourseRepository repository;
  late AddCourse useCase;
  final testCourse = Course.empty();
  setUp(() async {
    repository = MockCourseRepository();
    useCase = AddCourse(repository);
    registerFallbackValue(testCourse);
  });

  test(
    'given the AddCourse use case '
    'when use case is instantiated '
    'then call [CourseRepository.addCourse] '
    'and return [void]',
    () async {
      // Arrange
      when(
        () => repository.addCourse(course: any(named: 'course')),
      ).thenAnswer(
        (_) async => const Right(null),
      );
      // Act

      await useCase(testCourse);

      // Assert
      verify(
        () => repository.addCourse(course: any(named: 'course')),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
