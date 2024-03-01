part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

class UserCached extends OnBoardingState {
  const UserCached();
}

class CheckingOnBoardingStatus extends OnBoardingState {
  const CheckingOnBoardingStatus();
}

class OnBoardingStatusChecked extends OnBoardingState {
  const OnBoardingStatusChecked({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

class OnBoardingError extends OnBoardingState {
  const OnBoardingError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
