String themeTokenTemplate() => '''
import 'package:mix/mix.dart';

part 'theme_color_token.dart';
part 'theme_radius_token.dart';
part 'theme_text_style_token.dart';

final \$token = ThemeToken();

class ThemeToken {
  ThemeToken();

  final color = const ThemeColorToken();
  final textStyle = const ThemeTextStyleToken();
  final radius = const ThemeRadiusToken();
}
''';
