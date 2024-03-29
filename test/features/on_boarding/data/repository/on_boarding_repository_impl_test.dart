import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:education_app/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:education_app/features/on_boarding/domain/repository/on_boarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnBoardingLocalDataSource extends Mock implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepositoryImpl repositoryImpl;
  late CacheException cacheException;
  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repositoryImpl = OnBoardingRepositoryImpl(localDataSource);
    cacheException = const CacheException(message: 'Insufficient Storage');
  });

  test(
    'given OnBoardingRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [OnBoardingRepository]',
    () {
      expect(repositoryImpl, isA<OnBoardingRepository>());
    },
  );
  group('cacheFirstTimer - ', () {
    test(
      'given OnBoardingRepositoryImpl, '
      'when [OnBoardingRepositoryImpl.cacheFirstTimer] is called '
      'then complete call to local data source successfully ',
      () async {
        // Arrange
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );
        // Act
        final result = await repositoryImpl.cacheFirstTimer();
        // Assert
        expect(result, equals(const Right<Failure, void>(null)));
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
    test(
      'given OnBoardingRepositoryImpl, '
      'when [OnBoardingRepositoryImpl.cacheFirstTimer] is called '
      'and call to local data source is unsuccessful '
      'then return [CacheFailure]',
      () async {
        // Arrange
        when(
          () => localDataSource.cacheFirstTimer(),
        ).thenThrow(cacheException);
        // Act
        final result = await repositoryImpl.cacheFirstTimer();
        // Assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(
              CacheFailure(
                message: 'Insufficient Storage',
                statusCode: 500,
              ),
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
  // group('isUserFirstTimer - ', () {
  //   test(
  //     'given OnBoardingRepositoryImpl, '
  //     'when [OnBoardingRepositoryImpl.isUserFirstTimer] is called '
  //     'then complete call to local data source successfully ',
  //     () async {
  //       // Arrange
  //       when(() => localDataSource.isUserFirstTimer());
  //       // Act
  //       // Assert
  //     },
  //   );
  // });
}
