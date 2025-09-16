import '../../../generators/project_generator.dart';

String iconframeTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Frame for icons for ${config.projectName}
class IconFrame extends StatelessWidget {
  /// Constructor
  const IconFrame({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement IconFrame with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
