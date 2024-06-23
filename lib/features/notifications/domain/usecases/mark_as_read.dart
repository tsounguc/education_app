
import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';

class MarkAsRead extends UseCaseWithParams<void, String> {
  const MarkAsRead(this._repo);

  final NotificationRepository _repo;

  @override
  ResultFuture<void> call(String params) => _repo.markAsRead(params);
}
