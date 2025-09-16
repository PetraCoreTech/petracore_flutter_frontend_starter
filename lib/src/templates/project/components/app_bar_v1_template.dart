import '../../../generators/project_generator.dart';

String appbarv1Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Custom app bar with theming for ${config.projectName}
class AppBarV1 extends StatelessWidget {
  /// Constructor
  const AppBarV1({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement AppBarV1 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
