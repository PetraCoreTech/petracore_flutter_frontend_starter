String themeRadiusTokenTemplate() => '''
part of 'theme_token.dart';

class ThemeRadiusToken {
  const ThemeRadiusToken();

  /// Small radius token
  RadiusToken get small => const RadiusToken('small');

  /// Medium radius token
  RadiusToken get medium => const RadiusToken('medium');

  /// Large radius token
  RadiusToken get large => const RadiusToken('large');
}
''';
