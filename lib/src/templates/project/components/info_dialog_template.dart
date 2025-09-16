import '../../../generators/project_generator.dart';

String infodialogTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Info dialog component for ${config.projectName}
class InfoDialog extends StatelessWidget {
  /// Constructor
  const InfoDialog({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement InfoDialog with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
