import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/notifications/domain/entities/notification.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';

class GetNotifications extends StreamUseCase<List<Notification>> {
  const GetNotifications(this._repo);

  final NotificationRepository _repo;

  @override
  ResultStream<List<Notification>> call() => _repo.getNotifications();
}
