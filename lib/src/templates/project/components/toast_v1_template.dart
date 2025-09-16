import '../../../generators/project_generator.dart';

String toastV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/design_tokens/theme_token.dart';
import 'toast_type.dart';
import 'divider_v1.dart';

/// Toast with special styling for ${config.projectName}
class ToastV1 extends StatelessWidget {
  /// Constructor
  const ToastV1({
    required this.toastType,
    super.key,
    this.content,
    this.contentStyle,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.spacing,
    this.radius,
    this.borderRadius,
    this.constraints,
    this.margin,
    this.padding,
  });

  final ToastType toastType;
  final String? content;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? radius;
  final double? spacing;
  final Widget? icon;
  final TextStyle? contentStyle;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final surface = colors.surface.resolve(context);
    
    return Container(
      constraints:
          constraints ?? const BoxConstraints(maxHeight: 78, maxWidth: 550),
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ??
            switch (toastType) {
              ToastType.info => colors.toastInfo,
              ToastType.error => colors.toastError,
              ToastType.success => colors.toastSuccess,
            }
                .resolve(context),
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 4),
      ),
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                Icon(
                  switch (toastType) {
                    ToastType.info => Icons.info,
                    ToastType.error => Icons.error,
                    ToastType.success => Icons.check_circle,
                  },
                  color: iconColor ?? surface,
                ),
            Gap(spacing ?? 12),
            Flexible(
              child: Text(
                content ?? '',
                style: contentStyle ??
                    \$token.textStyle.paragraph2.resolve(context).copyWith(
                          color: switch (toastType) {
                            ToastType.error => colors.onToastError,
                            ToastType.success => colors.onToastSuccess,
                            ToastType.info => colors.onToastInfo,
                          }
                              .resolve(context),
                        ),
              ),
            ),
            const Gap(16),
            DividerV1(
              color: surface.withOpacity(0.12),
              height: 32,
              width: 1,
            ),
            const Gap(8),
            GestureDetector(
              onTap: () {
                // Implement dismiss logic here
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: iconColor ?? surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
''';
