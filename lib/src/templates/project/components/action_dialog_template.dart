import '../../../generators/project_generator.dart';

String actiondialogTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport 'package:gap/gap.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Action dialog component for ${config.projectName}
class ActionDialog extends StatelessWidget {
  /// Constructor
  const ActionDialog({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ActionDialog with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
