import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialLoadingIndicatorTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      child: child ??
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
    );
  }
}
''';
