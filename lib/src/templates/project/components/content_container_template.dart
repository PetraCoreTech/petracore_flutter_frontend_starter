import '../../../generators/project_generator.dart';

String contentcontainerTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Container for dialog content for ${config.projectName}
class ContentContainer extends StatelessWidget {
  /// Constructor
  const ContentContainer({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ContentContainer with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
