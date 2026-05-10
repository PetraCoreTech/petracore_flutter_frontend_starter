import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String initialsDisplayTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class InitialsDisplay extends StatelessWidget {
  const InitialsDisplay({
    super.key,
    this.title,
    this.textSize,
    this.textStyle,
    this.height,
    this.iconColor,
    this.iconData,
    this.borderRadius,
  });

  final String? title;
  final double? textSize;
  final TextStyle? textStyle;
  final double? height;
  final Color? iconColor;
  final IconData? iconData;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ProfileFrame(
      height: height,
      iconColor: iconColor,
      iconData: iconData,
      borderRadius: borderRadius,
      child: title != null
          ? Text(
              title!.split('').first.capitalize(),
              style: textStyle ??
                  \$token.textStyle.heading5.resolve(context).copyWith(
                        color: \$token.color.onSurfaceWhite.resolve(context),
                        fontSize: textSize,
                        height: 1,
                      ),
            )
          : const SizedBox.shrink(),
    );
  }
}
''';
