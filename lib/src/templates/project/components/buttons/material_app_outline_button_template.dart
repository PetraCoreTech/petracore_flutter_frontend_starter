import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialAppOutlineButtonTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

part 'app_outline_button_type.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    required this.text,
    super.key,
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
    this.textColor,
    this.textStyle,
    this.type = AppOutlineButtonType.primary,
    this.onTap,
    this.height,
    this.width,
    this.borderWidth,
    this.padding,
    this.radius,
  });

  factory AppOutlineButton.icon({
    required String text,
    required Widget icon,
    Key? key,
    double? height,
    double? width,
    double? borderWidth,
    double? spacing,
    double? radius,
    VoidCallback? onTap,
    Color? primaryColor,
    Color? secondary,
    Color? errorColor,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    AppOutlineButtonType type = AppOutlineButtonType.secondary,
    IconAlignment iconAlignment = IconAlignment.start,
  }) {
    return _AppOutlineButtonWithIcon(
      key: key,
      type: type,
      text: text,
      icon: icon,
      height: height,
      width: width,
      borderWidth: borderWidth,
      spacing: spacing,
      iconAlignment: iconAlignment,
      onTap: onTap,
      primaryColor: primaryColor,
      secondaryColor: secondary,
      errorColor: errorColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      radius: radius,
    );
  }

  final String text;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? radius;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final AppOutlineButtonType type;
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
      child: OutlinedButton(
        onPressed: onTap == null ? null : () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          onTap!();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          side: BorderSide(
            color: switch (type) {
              AppOutlineButtonType.primary => effectivePrimaryColor,
              AppOutlineButtonType.secondary => effectiveSecondaryColor,
              AppOutlineButtonType.error => effectiveErrorColor,
            },
            width: borderWidth ?? 1,
          ),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          textStyle: textStyle ?? theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
        child: Text(text),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    if (textColor != null) return textColor!;
    final theme = Theme.of(context);
    return switch (type) {
      AppOutlineButtonType.primary => theme.colorScheme.primary,
      AppOutlineButtonType.secondary => theme.colorScheme.secondary,
      AppOutlineButtonType.error => theme.colorScheme.error,
    };
  }
}

class _AppOutlineButtonWithIcon extends AppOutlineButton {
  const _AppOutlineButtonWithIcon({
    required super.text,
    required this.icon,
    required this.iconAlignment,
    super.key,
    super.primaryColor,
    super.secondaryColor,
    super.errorColor,
    super.textColor,
    super.textStyle,
    super.height,
    super.width,
    super.borderWidth,
    super.onTap,
    super.padding,
    super.radius,
    super.type = AppOutlineButtonType.primary,
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
      child: OutlinedButton(
        onPressed: onTap == null ? null : () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          onTap!();
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          side: BorderSide(
            color: switch (type) {
              AppOutlineButtonType.primary => effectivePrimaryColor,
              AppOutlineButtonType.secondary => effectiveSecondaryColor,
              AppOutlineButtonType.error => effectiveErrorColor,
            },
            width: borderWidth ?? 1,
          ),
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
      AppOutlineButtonType.primary => theme.colorScheme.primary,
      AppOutlineButtonType.secondary => theme.colorScheme.secondary,
      AppOutlineButtonType.error => theme.colorScheme.error,
    };
  }
}
''';
