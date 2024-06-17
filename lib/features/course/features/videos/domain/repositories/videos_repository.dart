import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/features/videos/domain/entities/video.dart';

abstract class VideosRepository {
  const VideosRepository();
  // Could make this a stream
  ResultFuture<List<Video>> getVideos(String courseId);

  ResultVoid addVideo(Video video);
}
