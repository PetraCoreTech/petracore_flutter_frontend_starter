String callActionButtonTemplate(String projectName) => '''
import 'package:flutter/material.dart';
import 'package:$projectName/core/core.dart';

class CallActionButton extends StatelessWidget {
  const CallActionButton({
    super.key,
    this.icon,
    this.label,
    this.onTap,
    this.isActive = false,
    this.isDestructive = false,
    this.size = 64,
    this.iconSize = 24,
  });

  final Widget? icon;
  final String? label;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isDestructive;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = isDestructive
        ? theme.colorScheme.error
        : isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceVariant;
    final fgColor = isDestructive
        ? theme.colorScheme.onError
        : isActive
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: IconTheme(
              data: IconThemeData(color: fgColor, size: iconSize),
              child: icon ?? const Icon(Icons.phone),
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
''';
