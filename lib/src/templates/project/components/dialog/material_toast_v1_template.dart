import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialToastV1Template(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class ToastV1 extends StatelessWidget {
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
    final theme = Theme.of(context);
    final surface = theme.colorScheme.onSurface;
    return Container(
      constraints:
          constraints ?? const BoxConstraints(maxHeight: 78, maxWidth: 550),
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ??
            switch (toastType) {
              ToastType.info => theme.snackBarTheme.backgroundColor,
              ToastType.error => theme.colorScheme.error,
              ToastType.success => theme.colorScheme.primary,
            },
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
            SizedBox(width: spacing ?? 12),
            Flexible(
              child: Text(
                content ?? '',
                style: contentStyle ??
                    theme.textTheme.bodyLarge?.copyWith(
                      color: switch (toastType) {
                        ToastType.error => theme.colorScheme.onError,
                        ToastType.success => theme.colorScheme.onPrimary,
                        ToastType.info => theme.snackBarTheme.contentTextStyle?.color ?? theme.colorScheme.onSurface,
                      },
                    ),
              ),
            ),
            const SizedBox(width: 16),
            DividerV1(
              color: surface.withValues(alpha: 0.12),
              height: 32,
              width: 1,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
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
