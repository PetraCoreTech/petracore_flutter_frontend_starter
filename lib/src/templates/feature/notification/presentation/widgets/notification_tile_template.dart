String notificationTileTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/notification/notification_index.dart';

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
      key: Key(notification.id ?? ''),
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
            fontWeight: notification.isRead == true ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          notification.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          _timeAgo(notification.dateCreated ?? DateTime.now()),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: onTap,
      ),
    );
  }

  IconData _iconForType(NotificationType type) => switch (type) {
    NotificationType.journal => Icons.book,
    NotificationType.friendRequest => Icons.person_add,
    NotificationType.friends => Icons.people,
    NotificationType.chat => Icons.chat,
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
