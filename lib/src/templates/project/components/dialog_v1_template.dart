import '../../../generators/project_generator.dart';

String dialogv1Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Basic dialog component for ${config.projectName}
class DialogV1 extends StatelessWidget {
  /// Constructor
  const DialogV1({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement DialogV1 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
