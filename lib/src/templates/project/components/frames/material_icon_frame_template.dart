import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialIconFrameTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class IconFrame extends StatelessWidget {
  const IconFrame({
    super.key,
    this.icon,
    this.iconData,
    this.padding,
    this.color,
    this.iconColor,
    this.shape,
    this.borderRadius,
    this.border,
    this.onTap,
    this.opticalSize,
    this.size,
    this.showSplash = false,
    this.splashColor,
    this.contentPadding,
  });
  final Widget? icon;
  final IconData? iconData;
  final double? padding;
  final double? opticalSize;
  final double? size;
  final Color? color;
  final Color? iconColor;
  final Color? splashColor;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool showSplash;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final child = DecoratedBox(
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.circle,
        borderRadius: borderRadius,
        border: border,
        color: color ?? Colors.transparent,
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.all(padding ?? 10),
        child: icon ??
            Icon(
              iconData,
              color: iconColor ?? theme.colorScheme.onSurface,
              size: size,
              opticalSize: opticalSize,
            ),
      ),
    );
    if (showSplash) {
      return InkWell(
        hoverColor: splashColor,
        splashColor: splashColor,
        highlightColor: splashColor,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      );
    }
    return HyperLinkText(onTap: onTap, child: child);
  }
}
''';
