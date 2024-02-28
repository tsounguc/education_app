import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/features/on_boarding/data/data_sources/onboarding_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;
  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(prefs);
  });
  group('cacheFirstTimer - ', () {
    test(
      'given OnBoardingLocalDataSourceImpl '
      'when [OnBoardingLocalDataSourceImpl.cacheFirstTimer] is called '
      'then call [SharedPreferences] to cache the data ',
      () async {
        // Arrange
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);
        // Act
        await localDataSource.cacheFirstTimer();
        // Assert
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
    test(
      'given OnBoardingLocalDataSourceImpl '
      'when [OnBoardingLocalDataSourceImpl.cacheFirstTimer] is called '
      'and call to [SharedPreferences] is unsuccessful '
      'then throw [CacheException]',
      () async {
        // Arrange
        when(() => prefs.setBool(any(), any())).thenThrow(Exception());
        // Act
        final methodCall = localDataSource.cacheFirstTimer;
        // Assert
        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });
}
