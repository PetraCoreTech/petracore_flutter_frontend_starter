import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String hyperLinkTextTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/core/core.dart';

class HyperLinkText extends StatelessWidget {
  const HyperLinkText({
    super.key,
    this.text,
    this.textColor,
    this.onTap,
    this.textStyle,
    this.textAlign,
    this.child,
  });

  final String? text;
  
  final Color? textColor;
  
  final TextStyle? textStyle;

  final TextAlign? textAlign;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    const transparent = Colors.transparent;
    return InkWell(
      hoverColor: transparent,
      focusColor: transparent,
      splashColor: transparent,
      highlightColor: transparent,
      onTap: onTap,
      child: child ??
          Text(
            text ?? '',
            textAlign: textAlign,
            style: textStyle ??
                \$token.textStyle.label3.resolve(context).copyWith(
                      color: textColor ??
                          \$token.color.primaryPressed.resolve(context),
                      height: 1.43,
                      fontWeight: FontWeight.w500,
                    ),
          ),
    );
  }
}
''';
