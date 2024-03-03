import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaResources.onBoardingBackground,
        child: Center(
          child: Lottie.asset(MediaResources.pageUnderConstruction),
        ),
      ),
    );
  }
}
