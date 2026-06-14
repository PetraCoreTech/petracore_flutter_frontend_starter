String callingModeToggleTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';

class CallingModeToggle extends StatelessWidget {
  const CallingModeToggle({
    super.key,
    this.isVideo = false,
    this.onToggle,
  });

  final bool isVideo;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: onToggle,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isVideo ? Icons.videocam : Icons.phone,
          color: theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
      ),
      tooltip: isVideo ? 'Switch to voice call' : 'Switch to video call',
    );
  }
}
''';
