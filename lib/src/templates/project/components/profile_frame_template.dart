import '../../../generators/project_generator.dart';

String profileframeTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Frame for profile content for ${config.projectName}
class ProfileFrame extends StatelessWidget {
  /// Constructor
  const ProfileFrame({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ProfileFrame with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
