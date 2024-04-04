import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';

class GetCourses extends UseCase<List<Course>> {
  GetCourses(this._repository);
  final CourseRepository _repository;

  @override
  ResultFuture<List<Course>> call() async => _repository.getCourses();
}
