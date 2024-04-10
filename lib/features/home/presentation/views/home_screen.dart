import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/features/home/presentation/refactors/home_body.dart';
import 'package:education_app/features/home/presentation/widget/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaResources.homeGradientBackground,
        child: HomeBody(),
      ),
    );
  }
}
