import '../../generators/project_generator.dart';

String themeTextStyleTokenTemplate(ProjectConfig config) => '''
part of 'theme_token.dart';

/// ThemeTextStyleToken class
class ThemeTextStyleToken {
  /// ThemeTextStyleToken Constructor
  const ThemeTextStyleToken();

  /// Heading 1
  TextStyleToken get heading1 => const TextStyleToken('heading1');

  /// Heading 2
  TextStyleToken get heading2 => const TextStyleToken('heading2');

  /// Heading 3
  TextStyleToken get heading3 => const TextStyleToken('heading3');

  /// Heading 4
  TextStyleToken get heading4 => const TextStyleToken('heading4');

  /// Heading 5
  TextStyleToken get heading5 => const TextStyleToken('heading5');

  /// Paragraph 1
  TextStyleToken get paragraph1 => const TextStyleToken('paragraph1');

  /// Paragraph 2
  TextStyleToken get paragraph2 => const TextStyleToken('paragraph2');

  /// Paragraph 3
  TextStyleToken get paragraph3 => const TextStyleToken('paragraph3');

  /// Paragraph 4
  TextStyleToken get paragraph4 => const TextStyleToken('paragraph4');

  /// Paragraph 5
  TextStyleToken get paragraph5 => const TextStyleToken('paragraph5');

  /// Label 1
  TextStyleToken get label1 => const TextStyleToken('label1');

  /// Label 2
  TextStyleToken get label2 => const TextStyleToken('label2');

  /// Label 3
  TextStyleToken get label3 => const TextStyleToken('label3');

  /// Label 4
  TextStyleToken get label4 => const TextStyleToken('label4');
}
''';
