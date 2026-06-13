String notificationTileTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/notification/presentation/entities/notification_item_entity.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.notification,
    super.key,
    this.onTap,
    this.onDismissed,
  });

  final NotificationItem notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_iconForType(notification.type)),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          notification.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          _timeAgo(notification.createdAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _iconForType(NotificationType type) => switch (type) {
    NotificationType.announcement => Icons.campaign,
    NotificationType.assignment => Icons.assignment,
    NotificationType.quiz => Icons.quiz,
    NotificationType.message => Icons.message,
    NotificationType.system => Icons.settings,
    NotificationType.general => Icons.notifications,
  };

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '\${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '\${diff.inHours}h ago';
    return '\${diff.inDays}d ago';
  }
}
''';
