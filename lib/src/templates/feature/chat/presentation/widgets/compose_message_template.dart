String composeMessageTemplate(String projectName) => '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ComposeMessage extends StatefulWidget {
  const ComposeMessage({
    required this.controller,
    required this.onSend,
    super.key,
  });
  final TextEditingController controller;
  final void Function({String? text, XFile? file}) onSend;

  @override
  State<ComposeMessage> createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  XFile? _pendingFile;

  void _handleFilePicked(XFile file, AttachmentType type) {
    Navigator.pop(context);
    setState(() => _pendingFile = file);
  }

  void _send() {
    final text = widget.controller.text.trim();
    if (text.isEmpty && _pendingFile == null) return;
    widget.onSend(
      text: text.isNotEmpty ? text : null,
      file: _pendingFile,
    );
    widget.controller.clear();
    setState(() => _pendingFile = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_pendingFile != null)
              Container(
                height: 60,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (_pendingFile!.mimeType != null &&
                        ['jpg', 'jpeg', 'png', 'gif', 'webp']
                            .contains(_pendingFile!.mimeType!.toLowerCase()))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          File(_pendingFile!.path),
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.insert_drive_file,
                            size: 24,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.insert_drive_file,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _pendingFile!.name,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () => setState(() => _pendingFile = null),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: theme.colorScheme.primary),
                  onPressed: () => AttachmentSheet.show(
                    context,
                    onFilePicked: _handleFilePicked,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      isDense: true,
                    ),
                    maxLines: 4,
                    minLines: 1,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: theme.colorScheme.primary),
                  onPressed: _send,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
''';
