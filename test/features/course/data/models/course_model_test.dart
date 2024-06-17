import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/features/course/data/models/course_model.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date = DateTime.fromMillisecondsSinceEpoch(
    timestampData['_seconds']!,
  ).add(
    Duration(microseconds: timestampData['_nanoseconds']!),
  );

  final timestamp = Timestamp.fromDate(date);

  final testCourseModel = CourseModel.empty();

  final testMap = jsonDecode(fixture('course.json')) as DataMap;
  testMap['createdAt'] = timestamp;
  testMap['updatedAt'] = timestamp;

  test(
    'given [CourseModel], '
    'when instantiated '
    'then instance should be a subclass of [Course] entity',
    () {
      // Arrange
      // Act
      // Assert
      expect(testCourseModel, isA<Course>());
    },
  );

  group('empty - ', () {
    test(
      'given [CourseModel] '
      'when empty is called, '
      'then return [CourseModel] with empty data',
      () {
        final result = CourseModel.empty();
        expect(result.title, '_empty.title');
      },
    );
  });

  group('fromMap - ', () {
    test(
        'given [CourseModel], '
        'when fromMap is called, '
        'then return [CourseModel] with correct data ', () {
      // Arrange
      // Act
      final result = CourseModel.fromMap(testMap);
      // Assert
      expect(result, equals(testCourseModel));
    });
  });

  group('toMap - ', () {
    test(
        'given [CourseModel], '
        'when toMap is called, '
        'then return [Map] with correct data ', () {
      // Arrange
      // Act
      final result = testCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');
      // Assert
      final map = DataMap.from(testMap)
        ..remove('createdAt')
        ..remove('updatedAt');
      expect(result, equals(map));
    });
  });

  group('copyWith - ', () {
    test(
        'given [CourseModel], '
        'when copyWith is called, '
        'then return [CourseModel] with updated data ', () {
      // Arrange
      // Act
      final result = testCourseModel.copyWith(title: 'New title');
      // Assert
      expect(result.title, equals('New title'));
    });
  });
}
