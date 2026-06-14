String chatBuilderTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ChatBuilder extends StatelessWidget {
  const ChatBuilder({this.searchQuery, super.key});
  final String? searchQuery;

  List<Chat> _filterChats(List<Chat> chats, String? query) {
    if (query == null || query.isEmpty) return chats;
    final q = query.toLowerCase();
    return chats.where((chat) {
      if (chat.isGroup && (chat.groupName?.toLowerCase().contains(q) ?? false)) return true;
      if (!chat.isGroup) {
        final name = chat.users.first['firstName']?.toString().toLowerCase() ?? '';
        if (name.contains(q)) return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
      stream: chatsUseCase.stream('currentUserId'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}'));
        }
        var chats = snapshot.data ?? [];
        chats = _filterChats(chats, searchQuery);
        if (chats.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chat_bubble_outline, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(height: 16),
                Text(
                  searchQuery != null ? 'No conversations match your search' : 'No conversations yet',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (searchQuery == null) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Start a new chat'),
                  ),
                ],
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => ChatTile(chat: chats[index]),
        );
      },
    );
  }
}
''';
