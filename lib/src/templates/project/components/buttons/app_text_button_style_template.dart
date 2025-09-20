String appTextButtonStyleTemplate() => '''
part of 'app_text_button.dart';

class AppTextButtonStyle {
  AppTextButtonStyle({
    required this.type,
    required this.context,
    this.textColor,
    this.textStyle,
    this.radius,
    this.padding,
    this.height,
    this.width,
  });
  final AppTextButtonType type;
  final BuildContext context;

  final Color? textColor;
  final TextStyle? textStyle;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;

  Style get container => Style(
        width != null ? \$box.width(width!) : null,
        height != null ? \$box.height(height!) : null,
        \$box.padding.as(
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        \$box.borderRadius(radius ?? 4),
        AppTextButtonType.primary(\$box.color(Colors.transparent)),
        AppTextButtonType.secondary(\$box.color(Colors.transparent)),
        AppTextButtonType.error(\$box.color(Colors.transparent)),
        // TODO(elijahpraise): create styling for tertiary
        // AppTextButtonType.tertiary(),
      ).applyVariant(type);

  Style get label {
    final fontSize = textStyle?.fontSize ?? 16.0;
    final fontWeight = textStyle?.fontWeight ?? FontWeight.w500;
    final height = textStyle?.height ?? 1.5;
    final color = textColor ?? textStyle?.color;
    return Style(
      \$text.style.fontFamily(AppConstants.fontFamily),
      AppTextButtonType.primary(
        \$text.style(
          color: color ?? \$token.color.primary(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppTextButtonType.secondary(
        \$text.style(
          color: color ?? \$token.color.secondary(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppTextButtonType.error(
        \$text.style(
          color: color ?? \$token.color.error(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      // AppTextButtonType.tertiary(),
    ).applyVariant(type);
  }
}
''';
