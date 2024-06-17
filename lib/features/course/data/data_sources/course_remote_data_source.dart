import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/features/chat/domain/data/models/group_model.dart';
import 'package:education_app/features/course/data/models/course_model.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();
  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(Course course);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl(
    this._firestore,
    this._storage,
    this._auth,
  );
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  @override
  Future<void> addCourse(Course course) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      // Create course firestore reference
      final courseReference = _firestore.collection('courses').doc();

      // Create group firestore reference
      final groupReference = _firestore.collection('groups').doc();

      // Create course model with course id and group id from references
      var courseModel = (course as CourseModel).copyWith(
        id: courseReference.id,
        groupId: groupReference.id,
      );

      if (courseModel.imageIsFile) {
        // Create image firebase storage reference if image is file
        final imageReference =
            _storage.ref().child('courses/${courseModel.id}/profile_image/${courseModel.title}-pfp');

        // use image reference to store image in firebase storage
        // set the courseModel image to the url returned
        await imageReference.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      // push course model info to document in firestore
      await courseReference.set(courseModel.toMap());

      // Create group model and set group id and course id references
      final groupModel = GroupModel(
        id: groupReference.id,
        name: course.title,
        members: const [],
        courseId: courseReference.id,
        groupImageUrl: courseModel.image,
      );

      // push group model info to document in firestore
      // return Future<void>
      return groupReference.set(groupModel.toMap());
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }
      return _firestore.collection('courses').get().then((value) => value.docs
          .map(
            (doc) => CourseModel.fromMap(doc.data()),
          )
          .toList());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }
}
