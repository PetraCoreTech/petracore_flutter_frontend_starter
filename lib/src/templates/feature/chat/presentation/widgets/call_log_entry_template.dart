String callLogEntryTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';

enum CallDirection { incoming, outgoing, missed }

class CallLogEntry extends StatelessWidget {
  const CallLogEntry({
    super.key,
    required this.name,
    this.avatarUrl,
    required this.direction,
    required this.isVideo,
    required this.timestamp,
    this.duration,
    this.onTap,
  });

  final String name;
  final String? avatarUrl;
  final CallDirection direction;
  final bool isVideo;
  final String timestamp;
  final String? duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = isVideo ? Icons.videocam : Icons.phone;
    final IconData directionIcon;
    final Color directionColor;

    switch (direction) {
      case CallDirection.incoming:
        directionIcon = Icons.arrow_downward;
        directionColor = theme.colorScheme.primary;
      case CallDirection.outgoing:
        directionIcon = Icons.arrow_upward;
        directionColor = theme.colorScheme.primary;
      case CallDirection.missed:
        directionIcon = Icons.arrow_downward;
        directionColor = theme.colorScheme.error;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        backgroundImage:
            avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              )
            : null,
      ),
      title: Text(name, style: theme.textTheme.bodyLarge),
      subtitle: Row(
        children: [
          Icon(directionIcon, size: 14, color: directionColor),
          const SizedBox(width: 4),
          Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          if (duration != null) ...[
            Text(
              duration!,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
          ],
          Text(timestamp, style: theme.textTheme.bodySmall),
        ],
      ),
      trailing: Icon(
        Icons.info_outline,
        size: 20,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
''';
