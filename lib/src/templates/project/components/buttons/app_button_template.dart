import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appButtonTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';

part 'app_button_style.dart';
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
    final style = AppButtonStyle(
      type: type,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      errorColor: errorColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      radius: radius,
      height: height,
      width: width,
    );
    
    return PressableBox(
      onPress: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        onTap?.call();
      },
      style: style.container,
      enableFeedback: true,
      child: Center(child: child ?? StyledText(text, style: style.label)),
    );
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
    final style = AppButtonStyle(
      type: type,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      errorColor: errorColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      radius: radius,
      height: height,
      width: width,
    );
    
    final gap = Gap(spacing ?? 8);
    return PressableBox(
      onPress: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        onTap?.call();
      },
      style: style.container,
      enableFeedback: true,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAlignment == IconAlignment.start) ...[icon, gap],
            StyledText(text, style: style.label),
            if (iconAlignment == IconAlignment.end) ...[gap, icon],
          ],
        ),
      ),
    );
  }
}
''';
