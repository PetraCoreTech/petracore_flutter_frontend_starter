import '../../../generators/project_generator.dart';

String appoutlinebuttonstyleTemplate(ProjectConfig config) => '''
part of 'app_outline_button.dart';\n

/// Style for outline button for ${config.projectName}
class AppOutlineButtonStyle extends StatelessWidget {
  /// Constructor
  const AppOutlineButtonStyle({
    super.key,
    // Add component-specific properties here
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement AppOutlineButtonStyle with mixtheme integration
    final colors = \$token.color;
    
    return Container(
      // Implement component UI here
      child: const Placeholder(),
    );
  }
}
''';
