import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String listFrameTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class ListFrame extends StatelessWidget {
  const ListFrame({
    super.key,
    this.height,
    this.maxHeight,
    this.child,
    this.width,
    this.spacing,
    this.radius,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.title,
    this.titleStyle,
    this.actionTextStyle,
    this.actionText,
    this.onTapAction,
    this.padding,
    this.crossAxisAlignment,
  });
  
  final String? actionText;
  final String? title;
  final double? height;
  final double? width;
  final double? spacing;
  final double? maxHeight;
  final Widget? child;
  final double? radius;
  final Color? borderColor;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? actionTextStyle;
  final VoidCallback? onTapAction;
  final BorderRadiusGeometry? borderRadius;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (title?.stringOrNull() != null) ...[
              Text(
                title!,
                style: titleStyle ??
                    \$token.textStyle.paragraph3.resolve(context).copyWith(
                          height: 1.33,
                          fontWeight: FontWeight.w500,
                          color: \$token.color.onSurfaceDark.resolve(context),
                        ),
              ),
            ],
            if (actionText != null && onTapAction != null)
              HyperLinkText(
                text: actionText!,
                textStyle: actionTextStyle ??
                    \$token.textStyle.paragraph3.resolve(context).copyWith(
                          color: \$token.color.primary.resolve(context),
                          height: 1.43,
                          fontWeight: FontWeight.w500,
                        ),
                onTap: onTapAction,
              ),
          ],
        ),
        if (title != null || actionText != null) Gap((spacing ?? 16).h),
        Container(
          height: height,
          width: width ?? size.width,
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? \$token.color.border.resolve(context),
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 12),
            color: backgroundColor ?? \$token.color.fill.resolve(context),
          ),
          child: child,
        ),
      ],
    );
  }
}
''';
