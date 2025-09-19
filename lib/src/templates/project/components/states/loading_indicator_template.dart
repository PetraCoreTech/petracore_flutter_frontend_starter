import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String loadingIndicatorTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/app.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: child ??
          CircularProgressIndicator(
            color: colors.primary.resolve(context),
          ),
    );
  }
}
''';
