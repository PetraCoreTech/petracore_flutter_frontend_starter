import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialInfoDisplayTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class InfoDisplay extends StatelessWidget {
  const InfoDisplay({
    this.title,
    this.subtitle,
    super.key,
    this.iconData,
    this.spacing,
    this.icon,
    this.padding,
    this.iconSize,
    this.iconColor,
    this.titleStyle,
    this.subtitleStyle,
    this.subtitleAlt,
    this.lottie,
    this.lottieSize,
  });

  final Widget? icon;
  final Widget? subtitleAlt;
  final String? iconData;
  final String? lottie;
  final double? iconSize;
  final double? lottieSize;
  final Color? iconColor;
  final double? spacing;
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            icon!
          else if (iconData != null)
            CustomIcon(
              icon: iconData!,
              height: iconSize ?? 32,
              color: iconColor,
            )
          else if (lottie != null)
            SizedBox(
              height: lottieSize ?? 280,
              child: Lottie.asset(lottie!),
            ),
          if (icon != null || iconData != null || lottie != null)
            SizedBox(height: spacing ?? 24),
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: titleStyle ??
                  theme.textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
          if (subtitle != null || subtitleAlt != null) const SizedBox(height: 8),
          if (subtitle != null)
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: subtitleStyle ?? theme.textTheme.bodySmall,
            )
          else if (subtitleAlt != null)
            subtitleAlt!,
        ],
      ),
    );
  }
}
''';
