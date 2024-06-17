import 'package:equatable/equatable.dart';

class Video extends Equatable {
  const Video({
    required this.id,
    required this.videoURL,
    required this.courseId,
    required this.uploadDate,
    this.thumbnailIsFile = false,
    this.thumbnail,
    this.title,
    this.tutor,
  });

  Video.empty()
      : this(
          id: '_empty.id',
          videoURL: '_empty.videoURL',
          courseId: '_empty.courseId',
          uploadDate: DateTime.now(),
        );

  final String id;
  final String? thumbnail;
  final String videoURL;
  final String? title;
  final String? tutor;
  final String courseId;
  final DateTime uploadDate;
  final bool thumbnailIsFile;

  @override
  List<Object?> get props => [id];
}
