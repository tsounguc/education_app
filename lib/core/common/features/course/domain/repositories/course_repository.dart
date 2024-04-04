import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedefs.dart';

abstract class CourseRepository {
  ResultFuture<List<Course>> getCourses();
  ResultVoid addCourse({
    required Course course,
  });
}
