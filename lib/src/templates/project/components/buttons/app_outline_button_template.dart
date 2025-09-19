import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appOutlineButtonTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';

part 'app_outline_button_style.dart';
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
    final style = AppOutlineButtonStyle(
      type: type,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding ?? context.buttonPadding(),
      radius: radius,
      height: height,
      width: width,
      borderWidth: borderWidth,
    );
    return PressableBox(
      onPress: () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        onTap?.call();
      },
      style: style.container,
      enableFeedback: true,
      child: Center(child: StyledText(text, style: style.label)),
    );
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
    final style = AppOutlineButtonStyle(
      type: type,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      errorColor: errorColor,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding ?? context.buttonPadding(),
      radius: radius,
      height: height,
      width: width,
      borderWidth: borderWidth,
    );
    final gap = Gap(spacing ?? 8);
    return PressableBox(
      key: key,
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
            StyledText(
              text,
              style: style.label,
            ),
            if (iconAlignment == IconAlignment.end) ...[gap, icon],
          ],
        ),
      ),
    );
  }
}
''';
