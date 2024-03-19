import 'package:education_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const id = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          'Sign Up Screen',
          style: context.theme.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
