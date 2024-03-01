import 'package:bloc/bloc.dart';
import 'package:education_app/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:education_app/features/on_boarding/domain/usecases/is_user_first_timer.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required IsUserFirstTimer isUserFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _isUserFirstTimer = isUserFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final IsUserFirstTimer _isUserFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimer();
    result.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (success) => emit(const UserCached()),
    );
  }

  Future<void> isUserFirstTimer() async {
    emit(const CheckingOnBoardingStatus());
    final result = await _isUserFirstTimer();
    result.fold(
      (failure) => emit(const OnBoardingStatusChecked(isFirstTimer: true)),
      (success) => emit(OnBoardingStatusChecked(isFirstTimer: success)),
    );
  }
}
