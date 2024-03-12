import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/auth/data/models/user_models.dart';
import 'package:education_app/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late LocalUserModel testModel;
  late DataMap testMap;
  setUpAll(() {
    testModel = const LocalUserModel.empty();
    testMap = jsonDecode(fixture('user.json')) as DataMap;
  });
  test(
    'given [LocalUserModel], '
    'when instantiated '
    'then instance should be a subclass of [LocalUser] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<LocalUser>());
    },
  );

  group('fromMap - ', () {
    test(
      'given [LocalUserModel], '
      'when fromMap is called, '
      'then return [LocalUserModel] with correct data ',
      () {
        // Arrange
        // Act
        final result = LocalUserModel.fromMap(testMap);
        // Assert
        expect(result, isA<LocalUserModel>());
        expect(result, equals(testModel));
      },
    );
  });

  group('toMap - ', () {
    test(
        'given [LocalUserModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testModel.toMap();
      // Assert
      expect(result, equals(testMap));
    });
  });

  group('copyWith - ', () {
    const testEmail = 'tsounguc@mail.gvsu.edu';
    test(
      'given [LocalUserModel], '
      'when copyWith is called, '
      'then return [LocalUserModel] with updated data ',
      () {
        // Arrange
        // Act
        final result = testModel.copyWith(email: testEmail);
        // Assert
        expect(result.email, equals(testEmail));
      },
    );
  });
}
