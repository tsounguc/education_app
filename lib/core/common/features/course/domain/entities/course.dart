import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.numberOfExams,
    required this.numberOfMaterials,
    required this.numberOfVideos,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    this.imageIsFile = false,
    this.description,
    this.image,
  });

  Course.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: null,
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          image: null,
          imageIsFile: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  final String id;
  final String title;
  final String? description;
  final int numberOfExams;
  final int numberOfMaterials;
  final int numberOfVideos;
  final String groupId;
  final String? image;
  final bool imageIsFile;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        // title,
        // description,
        // numberOfExams,
        // numberOfMaterials,
        // numberOfVideos,
        // groupId,
        // image,
        // imageIsFile,
        // createdAt,
        // updatedAt,
      ];
}
