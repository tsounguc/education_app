import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/domain/entities/course.dart';

abstract class CourseRepository {
  ResultFuture<List<Course>> getCourses();
  ResultVoid addCourse({
    required Course course,
  });
}
