String groupMemberTileTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';

class GroupMemberTile extends StatelessWidget {
  const GroupMemberTile({
    super.key,
    required this.name,
    this.avatarUrl,
    this.isAdmin = false,
    this.onRemove,
    this.onMakeAdmin,
  });

  final String name;
  final String? avatarUrl;
  final bool isAdmin;
  final VoidCallback? onRemove;
  final VoidCallback? onMakeAdmin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      subtitle: isAdmin
          ? Text(
              'Admin',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            )
          : null,
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
            case 'make_admin':
              onMakeAdmin?.call();
            case 'remove':
              onRemove?.call();
          }
        },
        itemBuilder: (context) => [
          if (!isAdmin)
            const PopupMenuItem(
              value: 'make_admin',
              child: Text('Make Admin'),
            ),
          const PopupMenuItem(
            value: 'remove',
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
}
''';
