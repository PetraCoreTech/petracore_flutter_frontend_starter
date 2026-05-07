import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialDotTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  const Dot({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.outline,
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
