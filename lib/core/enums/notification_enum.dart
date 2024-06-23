import 'package:education_app/core/resources/media_resources.dart';

enum NotificationCategory {
  TEST(value: 'test', image: MediaResources.test),
  VIDEO(value: 'video', image: MediaResources.video),
  MATERIAL(value: 'material', image: MediaResources.material),
  COURSE(value: 'course', image: MediaResources.course),
  NONE(value: 'none', image: MediaResources.course);
  // None just means it doesn't have a title

  const NotificationCategory({required this.value, required this.image});
  final String value;
  final String image;
}
