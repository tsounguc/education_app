import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/features/auth/domain/usescases/get_courses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repository.mock.dart';

void main() {
  late CourseRepository repository;
  late GetCourses useCase;
  setUp(() {
    repository = MockCourseRepository();
    useCase = GetCourses(repository);
  });
  final testResponse = [Course.empty()];

  test(
    'given the GetCourses use case '
    'when use case is instantiated '
    'then call [CourseRepository.getCourses] '
    'and return [List<Course>]',
    () async {
      // Arrange
      when(
        () => repository.getCourses(),
      ).thenAnswer((_) async => Right(testResponse));
      // Act
      final result = await useCase();
      // Assert
      expect(result, Right<dynamic, List<Course>>(testResponse));
      verify(() => repository.getCourses()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
