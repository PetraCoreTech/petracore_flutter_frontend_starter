import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialExpansionTileV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:${config.projectName}/core/core.dart';

class ExpansionTileV1 extends HookWidget {
  const ExpansionTileV1({
    required this.children,
    required this.title,
    required this.subtitle,
    super.key,
    this.trailing,
    this.itemSpacing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;
  final double? itemSpacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline;
    final isExpanded = useState(false);
    return ExpansionTile(
      onExpansionChanged: (value) {
        isExpanded.value = value;
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (!isExpanded.value) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ],
      ),
      tilePadding: const EdgeInsets.all(16),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: _border(borderColor),
      collapsedShape: _border(borderColor),
      trailing: IconFrame(
        iconData: isExpanded.value
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down,
        padding: 8,
        size: 16,
        iconColor: theme.colorScheme.onSurfaceVariant,
      ),
      children: children,
    );
  }

  ShapeBorder _border(Color color) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: color),
    );
  }
}
''';
