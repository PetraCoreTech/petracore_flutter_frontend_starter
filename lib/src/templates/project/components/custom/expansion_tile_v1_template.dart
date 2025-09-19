import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String expansionTileV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
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
    final colors = \$token.color;
    final borderColor = colors.border.resolve(context);
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
            style: \$token.textStyle.label3.resolve(context).copyWith(
                  color: colors.onSurfaceDark.resolve(context),
                ),
          ),
          if (!isExpanded.value) ...[
            Gap(4.h),
            Text(
              subtitle,
              style: \$token.textStyle.paragraph4.resolve(context).copyWith(
                    color: colors.onSurfaceLight.resolve(context),
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
        iconData: isExpanded.value ? Iconsax.arrow_up_2 : Iconsax.arrow_down_1,
        padding: 8,
        size: 16,
        iconColor: colors.onSurfaceDark.resolve(context),
      ),
      children: children,
    );
  }

  ShapeBorder _border(
    Color color,
  ) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: color,
      ),
    );
  }
}
''';
