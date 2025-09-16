import '../../../generators/project_generator.dart';

String toastv2Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport 'package:gap/gap.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Alternative toast component for ${config.projectName}
class ToastV2 extends StatelessWidget {
  /// Constructor
  const ToastV2({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ToastV2 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
