String notificationListTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/features/notification/notification_index.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    super.key,
    this.emptyWidget,
    this.itemBuilder,
    this.onNotificationTap,
    this.onDismissed,
  });

  final Widget? emptyWidget;
  final Widget Function(NotificationItem, VoidCallback?)? itemBuilder;
  final ValueChanged<String>? onNotificationTap;
  final ValueChanged<String>? onDismissed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<NotificationCubit>();
    final notifications = cubit.state.notifications;

    if (notifications.isEmpty) {
      return emptyWidget ?? const Center(child: Text('No notifications'));
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        if (itemBuilder != null) {
          return itemBuilder!(
            notification,
            () => onNotificationTap?.call(notification.id ?? ''),
          );
        }
        return NotificationTile(
          notification: notification,
          onTap: () {
            cubit.markAsRead(notification.id ?? '');
            onNotificationTap?.call(notification.id ?? '');
          },
          onDismissed: () {
            cubit.removeNotification(notification.id ?? '');
            onDismissed?.call(notification.id ?? '');
          },
        );
      },
    );
  }
}
''';
