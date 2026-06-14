String chatBubbleTemplate(String projectName) => '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:$projectName/features/chat/data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message,
    required this.isSent,
    super.key,
  });
  final Message message;
  final bool isSent;

  Widget _buildMediaContent(BuildContext context) {
    if (!message.hasMedia || message.mediaUrl == null) return const SizedBox.shrink();
    final theme = Theme.of(context);

    if (message.isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: message.mediaUrl!.startsWith('http')
            ? Image.network(
                message.mediaUrl!,
                width: 200,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 48),
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : const SizedBox(
                      width: 200, height: 160,
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
              )
            : Image.file(
                File(message.mediaUrl!),
                width: 200,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 48),
              ),
      );
    }

    if (message.isVideo) {
      return Container(
        width: 200,
        height: 120,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(child: Icon(Icons.play_circle_fill, size: 48)),
      );
    }

    // File or other media type
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.insert_drive_file, size: 24),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.mediaUrl!.split('/').last,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.hasMedia)
            Padding(
              padding: EdgeInsets.only(bottom: message.text != null ? 4 : 0),
              child: _buildMediaContent(context),
            ),
          if (message.text != null && message.text!.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxWidth: 232),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isSent
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceVariant,
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                message.text!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSent
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            ),
          if (isSent && message.read != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    message.read!.values.every((v) => v)
                        ? Icons.done_all
                        : Icons.done,
                    size: 14,
                    color: message.read!.values.every((v) => v)
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    message.read!.values.every((v) => v) ? 'Read' : 'Sent',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
''';
