import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/features/course/features/exams/domain/repos/exam_repo.dart';

class GetUserCourseExams extends UseCaseWithParams<List<UserExam>, String> {
  const GetUserCourseExams(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<UserExam>> call(String params) => _repo.getUserCourseExams(params);
}
