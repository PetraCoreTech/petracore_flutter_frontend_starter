import '../../../generators/project_generator.dart';

String loadingoverlayv1Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport 'loading_indicator.dart';

/// Loading overlay component for ${config.projectName}
class LoadingOverlayV1 extends StatelessWidget {
  /// Constructor
  const LoadingOverlayV1({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement LoadingOverlayV1 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
