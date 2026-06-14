String conversationListTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chatbot/presentation/entities/chat_message_entity.dart';
import 'package:$projectName/features/chatbot/presentation/widgets/message_bubble.dart';
import 'package:$projectName/features/chatbot/presentation/widgets/typing_indicator.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({
    super.key,
    required this.messages,
    this.isLoading = false,
    this.onLoadMore,
    this.emptyWidget,
  });

  final List<ChatMessage> messages;
  final bool isLoading;
  final VoidCallback? onLoadMore;
  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isLoading) {
      return emptyWidget ?? const Center(
        child: Text('Start a conversation'),
      );
    }

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == 0 && isLoading) {
          return const TypingIndicator(isVisible: true);
        }
        final messageIndex = isLoading ? index - 1 : index;
        final message = messages[messageIndex];
        return MessageBubble(message: message);
      },
    );
  }
}
''';
