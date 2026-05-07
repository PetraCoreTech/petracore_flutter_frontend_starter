import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialAppButtonTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

part 'app_button_type.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    super.key,
    this.type = AppButtonType.primary,
    this.onTap,
    this.child,
    this.height,
    this.width,
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
    this.textColor,
    this.textStyle,
    this.padding,
    this.radius,
  });

  factory AppButton.icon({
    required String text,
    required Widget icon,
    double? width,
    double? height,
    double? radius,
    double? spacing,
    VoidCallback? onTap,
    Color? primaryColor,
    Color? secondaryColor,
    Color? errorColor,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    AppButtonType type = AppButtonType.primary,
    IconAlignment iconAlignment = IconAlignment.start,
  }) {
    return _AppButtonWithIcon(
      type: type,
      text: text,
      icon: icon,
      padding: padding,
      radius: radius,
      height: height,
      width: width,
      spacing: spacing,
      iconAlignment: iconAlignment,
      onTap: onTap,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      errorColor: errorColor,
      textColor: textColor,
      textStyle: textStyle,
    );
  }

  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final String text;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? child;
  final AppButtonType type;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrimaryColor = primaryColor ?? theme.colorScheme.primary;
    final effectiveSecondaryColor = secondaryColor ?? theme.colorScheme.secondary;
    final effectiveErrorColor = errorColor ?? theme.colorScheme.error;
    final effectiveTextColor = textColor ?? _getTextColor(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap == null ? null : () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          onTap!();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: switch (type) {
            AppButtonType.primary => effectivePrimaryColor,
            AppButtonType.secondary => effectiveSecondaryColor,
            AppButtonType.error => effectiveErrorColor,
          },
          foregroundColor: effectiveTextColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          textStyle: textStyle ?? theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        child: child ?? Text(text),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;
    final theme = Theme.of(context);
    return switch (type) {
      AppButtonType.primary => theme.colorScheme.onPrimary,
      AppButtonType.secondary => theme.colorScheme.onSecondary,
      AppButtonType.error => theme.colorScheme.onError,
    };
  }
}

class _AppButtonWithIcon extends AppButton {
  const _AppButtonWithIcon({
    required super.text,
    required this.icon,
    required this.iconAlignment,
    super.primaryColor,
    super.secondaryColor,
    super.errorColor,
    super.textColor,
    super.textStyle,
    super.height,
    super.width,
    super.onTap,
    super.padding,
    super.radius,
    super.type = AppButtonType.primary,
    this.spacing,
  });

  final Widget icon;
  final IconAlignment iconAlignment;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrimaryColor = primaryColor ?? theme.colorScheme.primary;
    final effectiveSecondaryColor = secondaryColor ?? theme.colorScheme.secondary;
    final effectiveErrorColor = errorColor ?? theme.colorScheme.error;
    final effectiveTextColor = textColor ?? _getTextColor(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap == null ? null : () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          onTap!();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: switch (type) {
            AppButtonType.primary => effectivePrimaryColor,
            AppButtonType.secondary => effectiveSecondaryColor,
            AppButtonType.error => effectiveErrorColor,
          },
          foregroundColor: effectiveTextColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          textStyle: textStyle ?? theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAlignment == IconAlignment.start) ...[icon, SizedBox(width: spacing ?? 8)],
            Text(text),
            if (iconAlignment == IconAlignment.end) ...[SizedBox(width: spacing ?? 8), icon],
          ],
        ),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;
    final theme = Theme.of(context);
    return switch (type) {
      AppButtonType.primary => theme.colorScheme.onPrimary,
      AppButtonType.secondary => theme.colorScheme.onSecondary,
      AppButtonType.error => theme.colorScheme.onError,
    };
  }
}
''';
