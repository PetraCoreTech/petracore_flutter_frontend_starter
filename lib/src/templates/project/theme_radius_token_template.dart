import '../../generators/project_generator.dart';

String themeRadiusTokenTemplate(ProjectConfig config) => '''
part of 'theme_token.dart';

/// ThemeRadiusToken class
class ThemeRadiusToken {
  /// Constructor
  const ThemeRadiusToken();

  /// Small radius token
  RadiusToken get small => const RadiusToken('small');

  /// Medium radius token
  RadiusToken get medium => const RadiusToken('medium');

  /// Large radius token
  RadiusToken get large => const RadiusToken('large');
}
''';
