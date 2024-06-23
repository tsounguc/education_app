import 'package:dartz/dartz.dart';
import 'package:education_app/features/notifications/domain/entities/notification.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:education_app/features/notifications/domain/usecases/get_notifications.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'notification_repo.mock.dart';

void main() {
  late NotificationRepository repo;
  late GetNotifications usecase;

  setUp(() {
    repo = MockNotificationRepo();
    usecase = GetNotifications(repo);
  });

  test(
    'should return a [Stream<List<Notification>>] from the [NotificationRepo]',
    () async {
      when(() => repo.getNotifications()).thenAnswer((_) => Stream.value(const Right([])));

      final result = usecase();

      expect(result, emits(const Right<dynamic, List<Notification>>([])));

      verify(() => repo.getNotifications()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
