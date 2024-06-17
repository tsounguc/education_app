import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/features/course/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  CourseModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: null,
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          image: null,
          // imageIsFile: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
  CourseModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          title: map['title'] as String,
          description: map['description'] as String?,
          numberOfExams: (map['numberOfExams'] as num).toInt(),
          numberOfMaterials: (map['numberOfMaterials'] as num).toInt(),
          numberOfVideos: (map['numberOfVideos'] as num).toInt(),
          groupId: map['groupId'] as String,
          image: map['image'] as String?,
          imageIsFile: map['imageIsFile'] as bool? ?? false,
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: (map['updatedAt'] as Timestamp).toDate(),
        );

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    String? image,
    bool? imageIsFile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'groupId': groupId,
        'image': image,
        // 'imageIsFile': imageIsFile,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'numberOfVideos': numberOfVideos,
        'numberOfExams': numberOfExams,
        'numberOfMaterials': numberOfMaterials,
      };
}
