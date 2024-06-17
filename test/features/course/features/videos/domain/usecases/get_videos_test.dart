import 'package:dartz/dartz.dart';
import 'package:education_app/features/course/features/videos/domain/entities/video.dart';
import 'package:education_app/features/course/features/videos/domain/repositories/videos_repository.dart';
import 'package:education_app/features/course/features/videos/domain/usecases/get_videos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'video_repo.mock.dart';

void main() {
  late VideosRepository repository;
  late GetVideos usecase;

  setUp(() {
    repository = MockVideoRepository();
    usecase = GetVideos(repository);
  });

  final tVideo = Video.empty();

  test('should call [VideoRepo.addVideo]', () async {
    when(() => repository.getVideos(any())).thenAnswer((_) async => Right([tVideo]));

    final result = await usecase('testId');

    expect(result, isA<Right<dynamic, List<Video>>>());
    verify(() => repository.getVideos('testId')).called(1);
    verifyNoMoreInteractions(repository);
  });
}
