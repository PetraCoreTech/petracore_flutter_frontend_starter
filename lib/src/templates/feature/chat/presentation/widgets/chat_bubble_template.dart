String chatBubbleTemplate(String projectName) => '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:$projectName/core/core.dart';
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

    if (message.isFile) {
      return InkWell(
        onTap: () => OpenFilex.open(message.mediaUrl!),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 220),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _fileIcon(message.mediaUrl!),
                size: 28,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.mediaUrl!.split('/').last,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Tap to open',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.open_in_new,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  IconData _fileIcon(String url) {
    final ext = url.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'zip':
      case 'rar':
        return Icons.folder_zip;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Icons.audiotrack;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),
      child: Column(
        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (message.hasMedia)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
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
