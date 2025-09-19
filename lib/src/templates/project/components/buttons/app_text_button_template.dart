import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String appTextButtonTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:${config.projectName}/core/core.dart';

part 'app_text_button_style.dart';
part 'app_text_button_type.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.text,
    super.key,
    this.type = AppTextButtonType.primary,
    this.onTap,
    this.height,
    this.width,
    this.padding,
    this.radius,
    this.textColor,
    this.textStyle,
  });
  factory AppTextButton.icon({
    required String text,
    required Widget icon,
    Key? key,
    double? height,
    double? width,
    double? radius,
    VoidCallback? onTap,
    Color? textColor,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    AppTextButtonType type = AppTextButtonType.primary,
    IconAlignment iconAlignment = IconAlignment.start,
  }) {
    return _AppTextButtonWithIcon(
      key: key,
      type: type,
      text: text,
      icon: icon,
      height: height,
      width: width,
      iconAlignment: iconAlignment,
      onTap: onTap,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      radius: radius,
    );
  }
  final double? height;
  final double? width;
  final double? radius;
  final String text;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final AppTextButtonType type;

  @override
  Widget build(BuildContext context) {
    final style = AppTextButtonStyle(
      type: type,
      context: context,
      textStyle: textStyle,
      textColor: textColor,
      padding: padding,
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
      child: Center(child: StyledText(text, style: style.label)),
    );
  }
}

class _AppTextButtonWithIcon extends AppTextButton {
  const _AppTextButtonWithIcon({
    required super.text,
    required this.icon,
    required this.iconAlignment,
    super.key,
    super.height,
    super.width,
    super.padding,
    super.radius,
    super.textColor,
    super.textStyle,
    super.onTap,
    super.type = AppTextButtonType.primary,
  });
  final Widget icon;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    final style = AppTextButtonStyle(
      type: type,
      context: context,
      textColor: textColor,
      textStyle: textStyle,
      padding: padding,
      radius: radius,
      height: height,
      width: width,
    );
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
            if (iconAlignment == IconAlignment.start) ...[icon, const Gap(8)],
            StyledText(
              text,
              style: style.label,
            ),
            if (iconAlignment == IconAlignment.end) ...[const Gap(8), icon],
          ],
        ),
      ),
    );
  }
}
''';
