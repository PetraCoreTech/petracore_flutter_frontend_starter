import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String listTileV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/components/components_index.dart';

class ListTileV1 extends StatelessWidget {
  const ListTileV1({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.border,
    this.onTap,
    this.onHover,
    this.selected,
    this.selectedColor,
    this.contentPadding,
    this.borderRadius,
    this.titlePadding,
    this.iconPath,
    this.iconData,
    this.iconSize,
    this.iconColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final bool? selected;
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final Color? selectedColor;
  final EdgeInsets? contentPadding;
  final EdgeInsets? titlePadding;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHover;
  final String? iconPath;
  final IconData? iconData;
  final double? iconSize;
  final Color? iconColor;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (selected ?? false) ? selectedColor : Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: PaddedRow(
          padding: contentPadding ?? const EdgeInsets.all(16),
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (leading != null) ...[leading!, const Gap(16)],
            if (title != null) Expanded(child: title!),
            const Gap(8),
            if (trailing != null)
              trailing!
            else if (iconPath != null)
              CustomIcon(
                icon: iconPath!,
                height: iconSize ?? 24,
                color: iconColor,
              )
            else if (iconData != null)
              Icon(
                iconData,
                color: iconColor,
                size: iconSize,
              ),
          ],
        ),
      ),
    );
  }
}
''';
