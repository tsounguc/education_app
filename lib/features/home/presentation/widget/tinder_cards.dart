import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/resources/media_resources.dart';
import 'package:education_app/features/home/presentation/widget/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TinderCards extends StatefulWidget {
  const TinderCards({super.key});

  @override
  State<TinderCards> createState() => _TinderCardsState();
}

class _TinderCardsState extends State<TinderCards> with TickerProviderStateMixin {
  final CardController cardController = CardController();
  int totalCards = 10;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.width,
        width: context.width,
        child: TinderSwapCard(
          totalNum: totalCards,
          cardController: cardController,
          swipeEdge: 4,
          maxWidth: context.width,
          maxHeight: context.width * 0.9,
          minWidth: context.width * 0.71,
          minHeight: context.width * 0.85,
          allowSwipe: false,
          swipeUpdateCallback: (DragUpdateDetails details, Alignment alignment) {
            if (alignment.x < 0) {
            } else if (alignment.x > 0) {}
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            // if the card was the last card, add more cards to be swiped
            if (index == totalCards - 1) {
              setState(() {
                totalCards += 10;
              });
            }
          },
          cardBuilder: (context, index) {
            final isFirst = index == 0;
            final colorByIndex = index == 1 ? const Color(0xFFDA92FC) : const Color(0xFFDC95FB);
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: 110,
                  right: 0,
                  left: 0,
                  child: TinderCard(
                    isFirst: isFirst,
                    colour: isFirst ? null : colorByIndex,
                  ),
                ),
                if (isFirst)
                  Positioned(
                    bottom: 130,
                    right: 20,
                    child: Image.asset(
                      MediaResources.microscope,
                      height: 180,
                      width: 149,
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
