import '../../generators/project_generator.dart';

String themeTokenTemplate(ProjectConfig config) => '''
import 'package:mix/mix.dart';

part 'theme_color_token.dart';
part 'theme_radius_token.dart';
part 'theme_text_style_token.dart';

/// Token instance --> This instance is used
/// for calling your defined style tokens
final \$token = ThemeToken();

/// Token class
class ThemeToken {
  /// Constructor
  ThemeToken();

  ///
  final color = const ThemeColorToken();

  ///
  final textStyle = const ThemeTextStyleToken();

  ///
  final radius = const ThemeRadiusToken();
}
''';
