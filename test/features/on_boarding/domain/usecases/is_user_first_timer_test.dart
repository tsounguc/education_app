import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/features/on_boarding/domain/usecases/is_user_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late IsUserFirstTimer useCase;
  late OnBoardingRepository repository;
  setUp(() {
    repository = MockOnBoardingRepository();
    useCase = IsUserFirstTimer(repository);
  });

  test(
    'given IsUserFirstTimer use case '
    'when instantiated '
    'then [OnBoardingRepository.isUserFirstTimer] should be called '
    'and return true',
    () async {
      // Arrange
      when(() => repository.isUserFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(result, equals(const Right(true)));
      verify(() => repository.isUserFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given IsUserFirstTimer use case '
    'when instantiated '
    'and [OnBoardingRepository.IsUserFirstTimer] call unsuccessful '
    'then return [ServerFailure]  ',
    () async {
      // Arrange
      when(() => repository.isUserFirstTimer()).thenAnswer(
        (_) async => Left(
          ServerFailure(message: 'Unknown Error Occurred', statusCode: 500),
        ),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error Occurred',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => repository.isUserFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
