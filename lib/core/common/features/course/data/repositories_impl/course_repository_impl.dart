import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';

class CourseRepositoryImpl implements CourseRepository {
  const CourseRepositoryImpl(this._remoteDataSource);
  final CourseRemoteDataSource _remoteDataSource;
  @override
  ResultVoid addCourse({required Course course}) async {
    try {
      final result = await _remoteDataSource.addCourse(course);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final result = await _remoteDataSource.getCourses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
