String groupInfoScreenTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class GroupInfoScreen extends StatelessWidget {
  const GroupInfoScreen({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Info'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  backgroundImage: chat.groupImage != null
                      ? NetworkImage(chat.groupImage!)
                      : null,
                  child: chat.groupImage == null
                      ? Icon(
                          Icons.group,
                          size: 48,
                          color: theme.colorScheme.onSecondaryContainer,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              chat.displayName,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              '\${chat.users.length} participants',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Group Name'),
            trailing: Text(
              chat.displayName,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Members',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ...chat.users.map((user) {
            final id = user['id']?.toString() ?? '';
            final name = '\${user['firstName']} \${user['lastName']}';
            final isAdmin = chat.adminUsers?.contains(id) ?? false;
            return GroupMemberTile(
              name: name.trim(),
              isAdmin: isAdmin,
              onRemove: () {},
              onMakeAdmin: () {},
            );
          }),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: theme.colorScheme.error,
            ),
            title: Text(
              'Leave Group',
              style: TextStyle(color: theme.colorScheme.error),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
''';
