import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/notifications/domain/entities/notification.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';

class SendNotification extends UseCaseWithParams<void, Notification> {
  const SendNotification(this._repo);

  final NotificationRepository _repo;

  @override
  ResultFuture<void> call(Notification params) => _repo.sendNotification(params);
}
