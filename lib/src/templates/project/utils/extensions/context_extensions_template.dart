import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String contextExtensionsTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

extension ContextColorSchemeExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension IntExt on int {
  String times(String value) {
    return value * this;
  }
}

extension ListExt<T> on List<T> {
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}

extension ThemeExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
''';
