String chatInputFieldTemplate(String projectName) => '''
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.onSend,
    this.hintText = 'Type a message...',
    this.enabled = true,
  });

  final ValueChanged<String> onSend;
  final String hintText;
  final bool enabled;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
    setState(() => _hasText = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: widget.enabled,
                textInputAction: TextInputAction.send,
                maxLines: 4,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  isDense: true,
                ),
                onChanged: (text) =>
                    setState(() => _hasText = text.trim().isNotEmpty),
                onSubmitted: widget.enabled ? (_) => _onSend() : null,
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: widget.enabled && _hasText ? _onSend : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size(48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
''';
