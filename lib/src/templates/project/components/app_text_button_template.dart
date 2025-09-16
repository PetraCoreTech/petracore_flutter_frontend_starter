import '../../../generators/project_generator.dart';

String apptextbuttonTemplate(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport 'package:mix/mix.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Text button component for ${config.projectName}
class AppTextButton extends StatelessWidget {
  /// Constructor
  const AppTextButton({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement AppTextButton with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
