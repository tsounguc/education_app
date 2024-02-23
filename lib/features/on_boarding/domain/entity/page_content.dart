import 'package:education_app/core/resources/media_resources.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({required this.image, required this.title, required this.description});
  final String image;
  final String title;
  final String description;

  const PageContent.first()
      : this(
          image: MediaResources.casualReading,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed by the '
              "world's top Professor",
        );
  const PageContent.second()
      : this(
          image: MediaResources.casualLife,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed by the '
              "world's top Professor",
        );
  const PageContent.third()
      : this(
          image: MediaResources.casualMeditationScience,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed by the '
              "world's top Professor",
        );

  @override
  List<Object?> get props => [image, title, description];
}
