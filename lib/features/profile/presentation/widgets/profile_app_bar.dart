import 'dart:async';

import 'package:education_app/core/common/widgets/popup_item.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/resources/colours.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:education_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_horiz_outlined),
          surfaceTintColor: Colors.white,
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) {
            return [
              PopupMenuItem<void>(
                onTap: () => context.push(
                  BlocProvider(
                    create: (_) => serviceLocator<AuthBloc>(),
                    child: const EditProfileScreen(),
                  ),
                ),
                child: const PopupItem(
                  title: 'Edit Profile',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                // onTap: () => context.push(const Placeholder()),
                child: PopupItem(
                  title: 'Notifications',
                  icon: Icon(
                    IconlyLight.notification,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                // onTap: () => context.push(const Placeholder()),
                child: PopupItem(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
              PopupMenuItem<void>(
                height: 1,
                padding: EdgeInsets.zero,
                child: Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                  endIndent: 10,
                  indent: 10,
                ),
              ),
              PopupMenuItem<void>(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await serviceLocator<FirebaseAuth>().signOut();
                  unawaited(
                    navigator.pushNamedAndRemoveUntil(
                      '/',
                      (route) => false,
                    ),
                  );
                },
                child: const PopupItem(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
