import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String profileFrameTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class ProfileFrame extends StatelessWidget {
  const ProfileFrame({
    super.key,
    this.backgroundColor,
    this.child,
    this.height = 32,
    this.iconPadding,
    this.width,
    this.radius,
    this.borderRadius,
    this.iconColor,
    this.iconData,
  });

  final Color? backgroundColor;
  final Color? iconColor;
  final Widget? child;
  final double? height;
  final double? width;
  final double? radius;
  final double? iconPadding;
  final IconData? iconData;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    return SizedBox(
      height: height,
      width: width ?? height,
      child: IconFrame(
        shape: BoxShape.rectangle,
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 4),
        padding: iconPadding ?? 0,
        color: colors.onSurfaceLight.resolve(context),
        icon: Center(child: child),
        iconData: iconData,
        iconColor: iconColor,
      ),
    );
  }
}
''';
