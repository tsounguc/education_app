import 'package:audioplayers/audioplayers.dart';
import 'package:education_app/core/common/app/providers/notifications_notifier.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/features/notifications/presentation/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final newNotificationListenable = ValueNotifier<bool>(false);
  int? notificationCount;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
    newNotificationListenable.addListener(() {
      if (newNotificationListenable.value) {
        if (!context.read<NotificationsNotifier>().muteNotifications) {
          player.play(AssetSource('sounds/notification.mp3'));
        }
        newNotificationListenable.value = false;
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (_, state) {
        if (state is NotificationsLoaded) {
          if (notificationCount != null && notificationCount! < state.notifications.length) {
            newNotificationListenable.value = true;
          }
          notificationCount = state.notifications.length;
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoaded) {
          var showBadge = false;
          final unseenNotificationsLength = state.notifications.where((notification) => !notification.seen).length;

          showBadge = unseenNotificationsLength > 0;
          return IconButton(
            onPressed: () {
              debugPrint('Bell pressed');
              context.push(
                BlocProvider(
                  create: (_) => serviceLocator<NotificationCubit>(),
                  child: const NotificationsView(),
                ),
              );
            },
            icon: Badge(
              isLabelVisible: showBadge,
              label: showBadge ? Text('$unseenNotificationsLength') : null,
              offset: Offset.zero,
              child: const Icon(
                IconlyLight.notification,
              ),
            ),
          );
        }

        return const Icon(
          IconlyLight.notification,
        );
      },
    );
  }
}
