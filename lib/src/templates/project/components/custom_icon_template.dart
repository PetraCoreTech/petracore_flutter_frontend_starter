import '../../../generators/project_generator.dart';

String customiconTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Custom icon component for ${config.projectName}
class CustomIcon extends StatelessWidget {
  /// Constructor
  const CustomIcon({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement CustomIcon with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
