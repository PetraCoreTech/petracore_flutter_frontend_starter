String messageBuilderTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({required this.chatId, super.key});
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: messageUseCase.stream(chatId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}'));
        }
        final messages = snapshot.data ?? [];
        if (messages.isEmpty) {
          return const Center(child: Text('No messages yet'));
        }
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isSent = message.sender == 'currentUser';
            return ChatBubble(message: message, isSent: isSent);
          },
        );
      },
    );
  }
}
''';
