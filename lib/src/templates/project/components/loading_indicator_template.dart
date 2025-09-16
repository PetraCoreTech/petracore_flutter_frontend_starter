import '../../../generators/project_generator.dart';

String loadingIndicatorTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Loading indicator component with mixtheme integration for ${config.projectName}
class LoadingIndicator extends StatelessWidget {
  /// Constructor
  const LoadingIndicator({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    return Align(
      child: child ??
          CircularProgressIndicator(
            color: colors.primary.resolve(context),
          ),
    );
  }
}
''';
