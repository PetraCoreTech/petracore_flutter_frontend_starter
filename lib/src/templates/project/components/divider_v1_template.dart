import '../../../generators/project_generator.dart';

String dividerV1Template(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import '../../theme/design_tokens/theme_token.dart';

/// Custom divider component for ${config.projectName}
class DividerV1 extends StatelessWidget {
  /// Constructor
  const DividerV1({
    super.key,
    this.color,
    this.height,
    this.width,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  final Color? color;
  final double? height;
  final double? width;
  final double? thickness;
  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    final colors = \$token.color;
    final dividerColor = color ?? colors.divider.resolve(context);

    if (width != null) {
      // Vertical divider
      return Container(
        width: width,
        height: height,
        color: dividerColor,
      );
    } else {
      // Horizontal divider
      return Divider(
        color: dividerColor,
        height: height,
        thickness: thickness ?? 1,
        indent: indent,
        endIndent: endIndent,
      );
    }
  }
}
''';
