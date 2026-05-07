import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialDividerV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/app.dart';

class DividerV1 extends StatelessWidget {
  const DividerV1({
    super.key,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
  });
  final double? height;
  final double? width;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: height ?? 1,
      width: width ?? size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.dividerTheme.color,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
''';
