import '../../../generators/project_generator.dart';

String listframeTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Frame for lists for ${config.projectName}
class ListFrame extends StatelessWidget {
  /// Constructor
  const ListFrame({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ListFrame with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
