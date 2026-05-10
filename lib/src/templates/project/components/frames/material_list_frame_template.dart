import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialListFrameTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/core/core.dart';

class ListFrame extends StatelessWidget {
  const ListFrame({
    super.key,
    this.height,
    this.maxHeight,
    this.child,
    this.width,
    this.spacing,
    this.radius,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.title,
    this.titleStyle,
    this.actionTextStyle,
    this.actionText,
    this.onTapAction,
    this.padding,
    this.crossAxisAlignment,
  });

  final String? actionText;
  final String? title;
  final double? height;
  final double? width;
  final double? spacing;
  final double? maxHeight;
  final Widget? child;
  final double? radius;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? actionTextStyle;
  final VoidCallback? onTapAction;
  final BorderRadiusGeometry? borderRadius;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title?.isNotEmpty ?? false) ...[
              Text(
                title!,
                style: titleStyle ??
                    theme.textTheme.bodySmall?.copyWith(
                      height: 1.33,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
            if (actionText != null && onTapAction != null)
              HyperLinkText(
                text: actionText!,
                textStyle: actionTextStyle ??
                    theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      height: 1.43,
                      fontWeight: FontWeight.w500,
                    ),
                onTap: onTapAction,
              ),
          ],
        ),
        if (title != null || actionText != null) SizedBox(height: (spacing ?? 16)),
        Container(
          height: height,
          width: width ?? size.width,
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? theme.colorScheme.outline,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 12),
            color: backgroundColor ?? theme.colorScheme.surface,
          ),
          child: child,
        ),
      ],
    );
  }
}
''';
