import 'package:petracore_flutter_frontend_starter/src/design_presets/design_preset.dart';

String colorValuesTemplate(DesignPresetColors colors) {
  final buffer = StringBuffer();
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln();
  buffer.writeln('class AppColors {');

  for (final entry in colors.values.entries) {
    final value = entry.value;
    if (value == 'Colors.black') {
      buffer.writeln('  static const Color ${entry.key} = Colors.black;');
    } else if (value.startsWith('Color.fromRGBO')) {
      buffer.writeln('  static const Color ${entry.key} = $value;');
    } else {
      buffer.writeln('  static const Color ${entry.key} = Color($value);');
    }
  }

  buffer.writeln('}');
  return buffer.toString();
}
