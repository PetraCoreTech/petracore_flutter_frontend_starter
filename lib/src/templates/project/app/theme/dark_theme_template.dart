import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String darkThemeTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';
import 'package:${config.projectName}/app/theme/design_tokens/theme_token.dart';
import 'package:${config.projectName}/app/theme/themes/base_theme.dart';

/// Contains color mapping when device is in dark theme mode
final darkTheme = baseTheme.copyWith(
  colors: {
    \$token.color.primary: const Color(0xFF617AFA),
    \$token.color.onPrimary: const Color(0xFFFAFAFA),
    \$token.color.surface: const Color(0xFF1C1C21),
    \$token.color.onSurface: const Color(0xFFFAFAFA),
    // Add more dark theme color mappings as needed
    \$token.color.error: const Color(0xFFCF6679),
    \$token.color.onError: const Color(0xFF000000),
    \$token.color.secondary: const Color(0xFF03DAC6),
    \$token.color.onSecondary: const Color(0xFF000000),
  },
);
''';
