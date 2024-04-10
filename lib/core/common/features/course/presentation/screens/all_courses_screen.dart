import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/presentation/screens/course_details_screens.dart';
import 'package:education_app/core/common/widgets/course_tile.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';

class AllCoursesView extends StatelessWidget {
  const AllCoursesView({
    required this.courses,
    super.key,
  });

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const NestedBackButton(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: GradientBackground(
        image: MediaResources.homeGradientBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'All Subjects',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 40,
                runAlignment: WrapAlignment.spaceEvenly,
                children: courses
                    .map(
                      (course) => CourseTile(
                        course: course,
                        onTap: () => Navigator.of(context).pushNamed(
                          CourseDetailsScreen.id,
                          arguments: course,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
