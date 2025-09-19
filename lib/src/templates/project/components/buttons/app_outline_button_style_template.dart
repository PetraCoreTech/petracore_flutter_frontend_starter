String appOutlineButtonStyleTemplate() => '''
part of 'app_outline_button.dart';

class AppOutlineButtonStyle {
  AppOutlineButtonStyle({
    required this.type,
    required this.padding,
    this.primaryColor,
    this.secondaryColor,
    this.errorColor,
    this.textColor,
    this.textStyle,
    this.radius,
    this.height,
    this.width,
    this.borderWidth,
  });
  final AppOutlineButtonType type;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? errorColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? radius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final double? borderWidth;

  Style get container {
    final primary = primaryColor ?? \$token.color.primaryOutline();
    final secondary = secondaryColor ?? \$token.color.secondaryOutline();
    final error = errorColor ?? \$token.color.error();
    const transparent = Colors.transparent;
    return Style(
      width != null ? \$box.width(width!) : null,
      height != null ? \$box.height(height!) : null,
      \$box.padding.as(padding),
      \$box.borderRadius(radius ?? 4),
      \$box.border.width(borderWidth ?? 2),
      AppOutlineButtonType.primary(
        \$box.color(transparent),
        \$box.border(color: primary),
      ),
      AppOutlineButtonType.secondary(
        \$box.color(transparent),
        \$box.border(color: secondary),
      ),
      AppOutlineButtonType.error(
        \$box.color(transparent),
        \$box.border(color: error),
      ),
      // TODO(elijahpraise): create styling for tertiary
      // AppButtonType.tertiary(),
    ).applyVariant(type);
  }

  Style get label {
    final fontSize = textStyle?.fontSize ?? 16.0;
    final fontWeight = textStyle?.fontWeight ?? FontWeight.w500;
    final height = textStyle?.height ?? 1.5;
    final color = textColor ?? textStyle?.color;
    return Style(
      \$text.style.fontFamily(LenaCore.instance.font),
      AppOutlineButtonType.primary(
        \$text.style(
          color: color ?? \$token.color.primaryOutline(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppOutlineButtonType.secondary(
        \$text.style(
          color: color ?? \$token.color.secondaryOutline(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      AppOutlineButtonType.error(
        \$text.style(
          color: color ?? \$token.color.error(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
      // AppButtonType.tertiary(),
    ).applyVariant(type);
  }
}
''';
