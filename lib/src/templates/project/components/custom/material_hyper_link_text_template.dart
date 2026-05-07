import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialHyperLinkTextTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

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
                Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor ?? Theme.of(context).colorScheme.primary,
                  height: 1.43,
                  fontWeight: FontWeight.w500,
                ),
          ),
    );
  }
}
''';
