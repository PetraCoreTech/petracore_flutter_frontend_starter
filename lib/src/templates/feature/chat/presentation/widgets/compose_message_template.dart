String composeMessageTemplate(String projectName) => '''
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:$projectName/core/core.dart';
import 'package:$projectName/features/chat/chat_index.dart';

class ComposeMessage extends StatefulWidget {
  const ComposeMessage({
    required this.controller,
    required this.onSend,
    this.onUploadFile,
    super.key,
  });
  final TextEditingController controller;
  final void Function({String? text, String? fileUrl}) onSend;
  final Future<String> Function(XFile file)? onUploadFile;

  @override
  State<ComposeMessage> createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  XFile? _pendingFile;
  bool _isUploading = false;

  void _handleFilePicked(XFile file, AttachmentType type) {
    Navigator.pop(context);
    setState(() => _pendingFile = file);
  }

  Future<void> _send() async {
    final text = widget.controller.text.trim();
    if (text.isEmpty && _pendingFile == null) return;

    String? fileUrl;
    if (_pendingFile != null && widget.onUploadFile != null) {
      setState(() => _isUploading = true);
      try {
        fileUrl = await widget.onUploadFile!(_pendingFile!);
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload file')),
          );
        }
      }
      setState(() => _isUploading = false);
    }

    widget.onSend(
      text: text.isNotEmpty ? text : null,
      fileUrl: fileUrl,
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
            if (_isUploading)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: LinearProgressIndicator(),
              ),
            if (_pendingFile != null && !_isUploading)
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
                  onPressed: _isUploading
                      ? null
                      : () => AttachmentSheet.show(
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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isUploading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : IconButton(
                          key: const ValueKey('send'),
                          icon: Icon(Icons.send, color: theme.colorScheme.primary),
                          onPressed: _send,
                        ),
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
