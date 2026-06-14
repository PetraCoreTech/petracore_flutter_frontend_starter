String messageBubbleTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/features/chatbot/presentation/entities/chat_message_entity.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    this.onCopy,
  });

  final ChatMessage message;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final alignment = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.timestamp),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isUser
                        ? Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7)
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                if (onCopy != null && !isUser) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onCopy,
                    child: Icon(
                      Icons.copy,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '\${time.hour.toString().padLeft(2, '0')}:\${time.minute.toString().padLeft(2, '0')}';
  }
}
''';
