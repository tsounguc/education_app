import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/domain/repositories/course_repository.dart';

class AddCourse extends UseCaseWithParams<void, Course> {
  AddCourse(this._repository);
  final CourseRepository _repository;

  @override
  ResultVoid call(Course params) async => _repository.addCourse(
        course: params,
      );
}
