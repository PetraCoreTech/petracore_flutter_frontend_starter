import '../../../generators/project_generator.dart';

String expansiontilev1Template(ProjectConfig config) => '''
import 'flutter/material.dart';\nimport '../../theme/design_tokens/theme_token.dart';

/// Custom expansion tile for ${config.projectName}
class ExpansionTileV1 extends StatelessWidget {
  /// Constructor
  const ExpansionTileV1({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement ExpansionTileV1 with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
