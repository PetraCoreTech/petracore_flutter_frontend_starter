import '../../../generators/project_generator.dart';

String moreiconTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// More options icon for ${config.projectName}
class MoreIcon extends StatelessWidget {
  /// Constructor
  const MoreIcon({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement MoreIcon with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
