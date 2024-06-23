import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/notifications/domain/repositories/notification_repository.dart';

class ClearAll extends UseCase<void> {
  const ClearAll(this._repo);

  final NotificationRepository _repo;

  @override
  ResultFuture<void> call() => _repo.clearAll();
}
