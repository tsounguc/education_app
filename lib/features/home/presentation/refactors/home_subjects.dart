import 'package:education_app/core/common/widgets/course_tile.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/resources/colours.dart';
import 'package:education_app/features/course/domain/entities/course.dart';
import 'package:education_app/features/course/presentation/screens/all_courses_screen.dart';
import 'package:education_app/features/course/presentation/screens/course_details_screens.dart';
import 'package:education_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';

class HomeSubjects extends StatelessWidget {
  const HomeSubjects({required this.courses, super.key});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          sectionTitle: 'Course',
          seeAll: courses.length > 4,
          onSeeAll: () => context.push(
            AllCoursesView(
              courses: courses,
            ),
          ),
        ),
        const Text(
          'Explore our courses',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colours.neutralTextColour,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: courses
              .take(4)
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
      ],
    );
  }
}
