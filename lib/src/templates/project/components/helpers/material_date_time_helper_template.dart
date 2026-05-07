import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String materialDateTimeHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/material.dart';

class DateTimeHelper {
  DateTimeHelper(this.context);

  final BuildContext context;

  Future<DateTime?> pickDate({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final theme = Theme.of(context);
    final now = DateTime.now();

    return showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: theme.colorScheme.copyWith(
            primary: theme.colorScheme.primary,
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: theme.colorScheme.surface,
            shadowColor: theme.colorScheme.surface,
          ),
        ),
        child: child!,
      ),
      initialDate: initialDate,
      firstDate: firstDate ?? now,
      lastDate: lastDate ?? now.add(const Duration(days: 365)),
    );
  }

  Future<DateTime?> pickTime({
    TimeOfDay? initialTime,
  }) async {
    final theme = Theme.of(context);
    final res = await showTimePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: theme.colorScheme.copyWith(
            primary: theme.colorScheme.primary,
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: theme.colorScheme.surface,
            dialBackgroundColor: theme.colorScheme.surface,
          ),
        ),
        child: child!,
      ),
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (res != null) {
      final date = DateTime.now();
      final a = date.copyWith(hour: res.hour, minute: res.minute);
      return a;
    }
    return null;
  }
}
''';
