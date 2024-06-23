import 'package:education_app/core/common/screens/loading_view.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/features/notifications/presentation/widgets/no_notifications.dart';
import 'package:education_app/features/notifications/presentation/widgets/notification_options.dart';
import 'package:education_app/features/notifications/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        leading: const NestedBackButton(),
        actions: const [NotificationOptions()],
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationError) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotifications || state is ClearingNotifications) {
            return const LoadingView();
          } else if (state is NotificationsLoaded && state.notifications.isEmpty) {
            return const NoNotifications();
          } else if (state is NotificationsLoaded) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (_, index) {
                final notification = state.notifications[index];
                return Badge(
                  isLabelVisible: !notification.seen,
                  child: NotificationTile(notification),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}