import 'package:education_app/core/resources/media_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(MediaResources.onBoardingBackground),
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Lottie.asset(MediaResources.pageUnderConstruction),
            ),
          )),
    );
  }
}
