import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialSnackBarHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/app.dart';

class SnackBarHelper {
  SnackBarHelper(this.context);
  final BuildContext context;

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String content,
    double? radius,
    BorderRadiusGeometry? borderRadius,
    TextStyle? contentStyle,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.snackBarTheme.backgroundColor,
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: contentStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: theme.snackBarTheme.contentTextStyle?.color ?? theme.colorScheme.onSurface,
              ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8),
        ),
        duration: duration ?? const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar({
    required String content,
    TextStyle? contentStyle,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.colorScheme.error,
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: contentStyle ??
              theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onError),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar({
    required String content,
    TextStyle? contentStyle,
    Duration? duration,
  }) {
    final theme = Theme.of(context);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.colorScheme.primary,
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: contentStyle ??
              theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
''';
