import 'package:education_app/core/common/widgets/course_info_tile.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/presentation/widget/expandable_text.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen(
    this.course, {
    super.key,
  });
  final Course course;
  static const id = '/course-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(course.title),
        leading: const NestedBackButton(),
      ),
      body: GradientBackground(
        image: MediaResources.homeGradientBackground,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: context.height * 0.3,
                child: Center(
                  child: course.image != null
                      ? Image.network(course.image!)
                      : Image.asset(MediaResources.casualMeditation),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (course.description != null)
                    ExpandableText(
                      context,
                      text: course.description!,
                    ),
                  if (course.numberOfMaterials > 0 || course.numberOfVideos > 0 || course.numberOfExams > 0) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Subject Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (course.numberOfVideos > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaResources.courseInfoVideo,
                        title: '${course.numberOfVideos} Video(s)',
                        subtitle: 'Watch our tutorial '
                            'video for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed('/unknown-route', arguments: course),
                      ),
                    ],
                    if (course.numberOfExams > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaResources.courseInfoExam,
                        title: '${course.numberOfExams} Exam(s)',
                        subtitle: 'Take our exams for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed('/unknown-route', arguments: course),
                      ),
                    ],
                    if (course.numberOfMaterials > 0) ...[
                      const SizedBox(height: 10),
                      CourseInfoTile(
                        image: MediaResources.courseInfoMaterial,
                        title: '${course.numberOfExams} Material(s)',
                        subtitle: 'Access to ${course.numberOfMaterials.estimate} '
                            'materials for ${course.title}',
                        onTap: () => Navigator.of(context).pushNamed('/unknown-route', arguments: course),
                      ),
                    ],
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
