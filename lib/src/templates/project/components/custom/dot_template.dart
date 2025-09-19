import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String dotTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/app.dart';

class Dot extends StatelessWidget {
  const Dot({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? \$token.color.onSurfaceLight.resolve(context),
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        height: size ?? 8,
        width: size ?? 8,
      ),
    );
  }
}
''';
