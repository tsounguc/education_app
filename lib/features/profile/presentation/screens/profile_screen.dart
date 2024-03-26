import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/features/profile/presentation/refactors/profile_body.dart';
import 'package:education_app/features/profile/presentation/refactors/profile_header.dart';
import 'package:education_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaResources.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
