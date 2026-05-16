import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String dateTimeHelperTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';

class DateTimeHelper {
  DateTimeHelper(this.context);

  final BuildContext context;

  Future<DateTime?> pickDate({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    final colors = \$token.color;
    final surface = colors.surface.resolve(context);

    return showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: colors.primaryDisabled.resolve(context),
          ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: surface,
            surfaceTintColor: surface,
            shadowColor: surface,
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
    final colors = \$token.color;
    final surface = colors.surface.resolve(context);
    final res = await showTimePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: colors.primaryDisabled.resolve(context),
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: surface,
            dialBackgroundColor: surface,
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
