import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/resources/colours.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/features/course/presentation/widget/add_course_sheet.dart';
import 'package:education_app/features/profile/presentation/widgets/admin_button.dart';
import 'package:education_app/features/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: Colours.physicsTileColour,
                    infoIcon: const Icon(
                      IconlyLight.document,
                      size: 24,
                      color: Color(0xFF767DFF),
                    ),
                    infoTitle: 'Courses',
                    infoValue: user!.enrolledCourseIds.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: Colours.languageTileColour,
                    infoIcon: Image.asset(
                      MediaResources.scoreboard,
                      height: 24,
                      width: 24,
                    ),
                    infoTitle: 'Score',
                    infoValue: user.points.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: Colours.biologyTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFF56AEFF),
                      size: 24,
                    ),
                    infoTitle: 'Followers',
                    infoValue: user.followers.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: Colours.chemistryTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFFFF84AA),
                    ),
                    infoTitle: 'Following',
                    infoValue: user.following.length.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (context.currentUser?.isAdmin == true) ...[
              AdminButton(
                label: 'Add Course',
                icon: IconlyLight.paper_upload,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    elevation: 0,
                    useSafeArea: true,
                    builder: (_) => BlocProvider(
                      create: (_) => serviceLocator<CourseCubit>(),
                      child: const AddCourseSheet(),
                    ),
                  );
                },
              ),
            ]
          ],
        );
      },
    );
  }
}
