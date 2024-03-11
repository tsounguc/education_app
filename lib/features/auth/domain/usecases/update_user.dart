import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repository);
  final AuthRepository _repository;

  @override
  ResultVoid call(UpdateUserParams params) {
    return _repository.updateUser(
      action: params.action,
      userData: params.userData,
    );
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.displayName,
          userData: '',
        );

  final UpdateUserAction action;
  final dynamic userData;
  @override
  List<Object?> get props => [action, userData];
}
