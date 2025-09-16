import '../../generators/project_generator.dart';

String themeBarrelTemplate(ProjectConfig config) => '''
// Theme system exports for ${config.projectName}
export 'color_values.dart';
export 'design_tokens/theme_token.dart';
export 'themes/base_theme.dart';
export 'themes/light_theme.dart';
export 'themes/dark_theme.dart';
''';
