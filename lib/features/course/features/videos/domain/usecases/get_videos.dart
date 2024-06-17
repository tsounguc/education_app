import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/features/videos/domain/entities/video.dart';
import 'package:education_app/features/course/features/videos/domain/repositories/videos_repository.dart';

class GetVideos extends UseCaseWithParams<List<Video>, String> {
  const GetVideos(this._repository);

  final VideosRepository _repository;

  @override
  ResultFuture<List<Video>> call(String params) => _repository.getVideos(params);
}
