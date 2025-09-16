import '../../../generators/project_generator.dart';

String tabbarv1Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Custom tab bar with theming for ${config.projectName}
class TabBarV1 extends StatelessWidget {
  /// Constructor
  const TabBarV1({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement TabBarV1 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
