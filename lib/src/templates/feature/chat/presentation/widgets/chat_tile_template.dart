String chatTileTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({required this.chat, super.key});
  final Chat chat;

  String _getInitials(Chat chat) {
    if (chat.isGroup) {
      return (chat.displayName.isNotEmpty ? chat.displayName[0] : 'G');
    }
    final first = chat.users.first['firstName']?.toString() ?? '';
    final last = chat.users.first['lastName']?.toString() ?? '';
    return '\${first.isNotEmpty ? first[0] : ''}\${last.isNotEmpty ? last[0] : ''}';
  }

  Widget _buildLeading(BuildContext context) {
    final theme = Theme.of(context);
    if (chat.isGroup) {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.secondaryContainer,
        child: chat.groupImage != null
            ? ClipOval(
                child: Image.network(chat.groupImage!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Icon(Icons.group, color: theme.colorScheme.onSecondaryContainer)),
              )
            : Icon(Icons.group, color: theme.colorScheme.onSecondaryContainer),
      );
    }
    return CircleAvatar(
      backgroundColor: theme.colorScheme.primaryContainer,
      backgroundImage: chat.displayImage.isNotEmpty
          ? NetworkImage(chat.displayImage)
          : null,
      child: chat.displayImage.isEmpty
          ? Text(
              _getInitials(chat),
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unread = chat.unreadMessages.values.fold(0, (a, b) => a + b);
    return ListTile(
      leading: _buildLeading(context),
      title: Text(
        chat.displayName,
        style: theme.textTheme.bodyLarge,
      ),
      subtitle: Text(
        chat.subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chat.lastMessage != null && chat.lastMessage!.hasMedia)
            Icon(Icons.image, size: 14, color: theme.colorScheme.onSurfaceVariant),
          if (chat.lastMessage != null && chat.lastMessage!.hasMedia && unread > 0)
            const SizedBox(width: 4),
          if (unread > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unread > 99 ? '99+' : unread.toString(),
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
''';
