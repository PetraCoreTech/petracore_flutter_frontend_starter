String chatSearchUserBuilderTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatSearchUserBuilder extends StatelessWidget {
  const ChatSearchUserBuilder({
    super.key,
    this.onUserTap,
    this.selectedIds,
  });

  final void Function(Map<String, dynamic> user)? onUserTap;
  final Set<String>? selectedIds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Search for users to chat with',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
