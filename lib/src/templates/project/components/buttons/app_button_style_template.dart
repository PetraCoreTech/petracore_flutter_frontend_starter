String appButtonStyleTemplate() => '''
part of 'app_button.dart';

class AppButtonStyle {
  AppButtonStyle({
    required this.type,
    required this.padding,
    this.primaryColor,w
    this.secondaryColor,
    this.errorColor,
    this.textColor,
    this.textStyle,
    this.radius,
    this.height,
    this.width,
  });

  final AppButtonType type;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? radius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;

  Style get container => Style(
    width != null ? \$box.width(width!) : null,
    height != null ? \$box.height(height!) : null,
    \$box.padding.as(padding),
    \$box.borderRadius(radius ?? 8),
    AppButtonType.primary(
      \$box.color(primaryColor ?? \$token.color.primary()),
    ),
    AppButtonType.secondary(
      \$box.color(secondaryColor ?? \$token.color.secondary()),
    ),
    AppButtonType.error(
      \$box.color(errorColor ?? \$token.color.error()),
    ),
  ).applyVariant(type);

  Style get label {
    final fontSize = textStyle?.fontSize ?? 16.0;
    final fontWeight = textStyle?.fontWeight ?? FontWeight.w500;
    final height = textStyle?.height ?? 1.5;
    final color = textColor ?? textStyle?.color;
    
    return Style(
      \$text.style.fontFamily(AppConstants.fontFamily),
      AppButtonType.primary(
        \$text.style(
          color: color ?? \$token.color.onPrimary(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppButtonType.secondary(
        \$text.style(
          color: color ?? \$token.color.onSecondary(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppButtonType.error(
        \$text.style(
          color: color ?? \$token.color.onError(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    ).applyVariant(type);
  }
}
''';
