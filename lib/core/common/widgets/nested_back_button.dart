import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatefulWidget {
  const NestedBackButton({super.key});

  @override
  State<NestedBackButton> createState() => _NestedBackButtonState();
}

class _NestedBackButtonState extends State<NestedBackButton> {
  bool canPop = true;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        try {
          context.pop();
        } catch (_) {
          if (Navigator.canPop(context)) {
            setState(() {
              canPop = false;
            });
          } else {
            setState(() {
              canPop = false;
            });
          }
        }
      },
      canPop: canPop,
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(Icons.arrow_back_ios_new)
            : const Icon(Icons.arrow_back),
      ),
    );
  }
}
