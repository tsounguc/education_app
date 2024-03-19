import 'package:education_app/core/common/screens/loading_view.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/resources/colours.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/features/on_boarding/domain/entity/page_content.dart';
import 'package:education_app/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String id = '/onBoardingScreen';
  // static const String id = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().isUserFirstTimer();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaResources.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatusChecked && state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/');
            } else if (state is UserCached) {
              // TODO(User-Cached-Handler): Push to the appropriate screen
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          builder: (context, state) {
            if (state is CheckingOnBoardingStatus || state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                Positioned(
                  child: PageView(
                    controller: pageController,
                    scrollBehavior: const MaterialScrollBehavior(),
                    children: const [
                      OnBoardingBody(pageContent: PageContent.first()),
                      OnBoardingBody(pageContent: PageContent.second()),
                      OnBoardingBody(pageContent: PageContent.third()),
                    ],
                  ),
                ),
                Positioned(
                  left: context.width * 0.4,
                  bottom: context.height * 0.4,
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
