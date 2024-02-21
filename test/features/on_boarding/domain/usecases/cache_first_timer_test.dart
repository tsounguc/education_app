import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:education_app/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late CacheFirstTimer useCase;
  late OnBoardingRepository repository;
  setUp(() {
    repository = MockOnBoardingRepository();
    useCase = CacheFirstTimer(repository);
  });

  test(
    'given CacheFirstTimer use case '
    'when instantiated '
    'then [OnBoardingRepository.cacheFirstTimer] should be called ',
    () async {
      // Arrange
      when(() => repository.cacheFirstTimer()).thenAnswer(
        (_) async => const Right(null),
      );
      // Act
      final result = await useCase();
      // Assert
      expect(result, equals(const Right(null)));
      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given CacheFirstTimer use case '
    'when instantiated '
    'and [OnBoardingRepository.cacheFirstTimer] call unsuccessful '
    'then return [ServerFailure]  ',
    () async {
      // Arrange
      when(() => repository.cacheFirstTimer()).thenAnswer(
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
      verify(() => repository.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
