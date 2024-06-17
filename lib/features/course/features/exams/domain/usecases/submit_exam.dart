import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/features/exams/domain/entities/user_exam.dart';
import 'package:education_app/features/course/features/exams/domain/repos/exam_repo.dart';

class SubmitExam extends UseCaseWithParams<void, UserExam> {
  const SubmitExam(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<void> call(UserExam params) => _repo.submitExam(params);
}
