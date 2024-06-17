import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/features/videos/domain/entities/video.dart';
import 'package:education_app/features/course/features/videos/domain/repositories/videos_repository.dart';

class AddVideo extends UseCaseWithParams<void, Video> {
  const AddVideo(this._repository);

  final VideosRepository _repository;

  @override
  ResultFuture<void> call(Video params) => _repository.addVideo(params);
}
