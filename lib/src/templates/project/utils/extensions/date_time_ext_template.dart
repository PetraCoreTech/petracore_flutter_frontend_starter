import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dateTimeExtTemplate(ProjectConfig config) => """
import 'package:${config.projectName}/core/core.dart';

extension DateTimeExtensions on DateTime {
  static DateTime? maybeParse(String? date) {
    if (date != null) {
      return DateTime.parse(date);
    }
    return null;
  }

  String toDateTimeJson() {
    final date = this;
    final timezoneOffsetHours = DateTime.now().timeZoneOffset.inHours;
    final res = date.subtract(Duration(hours: timezoneOffsetHours));
    return res.toIso8601String();
  }

  String toDateTimeJsonV2() {
    final date = this;
    final offset = date.timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';
    final isoString = date.toIso8601String();
    return '\$isoString\$sign\$hours:\$minutes';
  }

  String toDateTimeJsonV3() {
    final date = this;
    return '\${date.year}-\${date.month}-\${date.day}';
  }

  DateTime fromDateTimeJson() {
    final date = this;
    final timezoneOffsetHours = DateTime.now().timeZoneOffset.inHours;
    final res = date.add(Duration(hours: timezoneOffsetHours));
    return res;
  }

  String dayOfWeek({bool isFull = true}) {
    final date = toLocal();
    final short = DateFormat.E().format(date);
    final full = DateFormat.EEEE().format(date);
    return isFull ? full : short;
  }

  String monthInit({bool isFull = true}) {
    final date = toLocal();
    final short = DateFormat.MMM().format(date);
    final full = DateFormat.MMMM().format(date);
    return isFull ? full : short;
  }

  String fullDate({bool day = true}) {
    final date = toLocal();
    final dayOfMonth = date.day;
    final year = date.year;
    final month = monthInit();
    final dayVal = day ? '\${dayOfWeek()}, ' : '';
    return '\$dayVal\$month \$dayOfMonth, \$year';
  }

  String fullDateV2() {
    final date = toLocal();
    final day = date.dayOfWeek(isFull: false).capitalize();
    final month = date.monthInit(isFull: false).capitalize();
    return '\$day, \${date.day} \$month \${date.year}';
  }

  String fullDateV3() {
    final date = toLocal();
    final month = date.monthInit(isFull: false).capitalize();
    return '\$month \${date.day}, \${date.year}';
  }

  String fullDateV4() {
    final date = toLocal();
    final month = date.monthInit(isFull: false).capitalize();
    final time = DateFormat('hh:mm').format(date);
    final am = DateFormat('a').format(date);
    return '\$month \${date.day}, \${date.year} at \$time\${am.toUpperCase()}';
  }

  String dateWithOrdinal() {
    final date = toLocal();
    final month = date.monthInit(isFull: false).capitalize();
    final now = DateTime.now();
    final yr = now.year != date.year ? ' \${date.year}' : '';
    return '\$month \${date.day}\${date.day.ordinal()}\$yr';
  }

  String timeFormat() {
    final date = toLocal();
    final am = DateFormat('a').format(date);
    final time = DateFormat('hh:mm').format(date);
    return '\$time \${am.toLowerCase()}';
  }

  TimeOfDay timeOfDay() {
    final date = toLocal();
    final res = TimeOfDay(hour: date.hour, minute: date.minute);
    return res;
  }

  String convertDaysToWeeksAndDays(int days) {
    const daysInWeek = 7;
    final weeks = days ~/ daysInWeek;
    final remainingDays = days % daysInWeek;
    final weeksString = weeks > 0 ? '\${weeks}week'.pluralize(count: weeks) : '';
    final daysString =
        remainingDays > 0 ? '\${remainingDays}day'.pluralize(count: days) : '';
    if (weeksString.isNotEmpty && daysString.isNotEmpty) {
      return '\$weeksString \$daysString';
    }
    return weeksString.isNotEmpty ? weeksString : daysString;
  }

  String convertDaysToMonthsAndDays(int days) {
    const daysInMonth = 30;
    final months = days ~/ daysInMonth;
    final remainingDays = days % daysInMonth;
    final monthsString =
        months > 0 ? '\${months}month'.pluralize(count: months) : '';
    final daysString = remainingDays > 0
        ? '\${remainingDays}day'.pluralize(count: remainingDays)
        : '';
    if (monthsString.isNotEmpty && daysString.isNotEmpty) {
      return '\$monthsString \$daysString';
    }
    return monthsString.isNotEmpty ? monthsString : daysString;
  }

  DateTime copyCurrentDate() {
    final date = toLocal();
    final now = DateTime.now();
    return date.copyWith(year: now.year, month: now.month, day: now.day);
  }

  String durationFromDateTime({DateTime? value, bool short = false}) {
    final date = toLocal();
    final now = value ?? DateTime.now().toLocal();
    final diff = now.difference(date).abs();
    final seconds = diff.inSeconds;
    final minutes = diff.inMinutes;
    final hrs = diff.inHours;
    final days = diff.inDays;
    final weeks = days ~/ 7;
    final months = days ~/ 30;
    final yrs = days ~/ 365;
    if (seconds < 60) {
      final sec = short ? 'sec' : 'second';
      return '\$seconds \$sec'.pluralize(count: seconds);
    } else if (minutes < 60) {
      final min = short ? 'min' : 'minute';
      return '\$minutes \$min'.pluralize(count: minutes);
    } else if (hrs <= 24) {
      final hr = short ? 'hr' : 'hour';
      return '\$hrs \$hr'.pluralize(count: hrs);
    } else if (days <= 7) {
      final dy = short ? 'dy' : 'day';
      return '\$days \$dy'.pluralize(count: days);
    } else if (weeks <= 4) {
      final wk = short ? 'wk' : 'week';
      return '\$weeks \$wk'.pluralize(count: weeks);
    } else if (months <= 12) {
      final mth = short ? 'mth' : 'month';
      return '\$months \$mth'.pluralize(count: months);
    } else {
      final yr = short ? 'yr' : 'year';
      return '\$yrs \$yr'.pluralize(count: yrs);
    }
  }

  String durationTillDateTime({DateTime? value, bool short = false}) {
    final date = toLocal();
    final now = value ?? DateTime.now();
    final diff = date.difference(now).abs();
    final seconds = diff.inSeconds;
    final minutes = diff.inMinutes;
    final hrs = diff.inHours;
    final days = diff.inDays;
    final weeks = days ~/ 7;
    final months = days ~/ 30;
    final yrs = days ~/ 365;
    if (seconds < 60) {
      final sec = short ? 'sec' : 'second';
      return '\$seconds \$sec'.pluralize(count: seconds);
    } else if (minutes < 60) {
      final min = short ? 'min' : 'minute';
      return '\$minutes \$min'.pluralize(count: minutes);
    } else if (hrs <= 24) {
      final hr = short ? 'hr' : 'hour';
      return '\$hrs \$hr'.pluralize(count: hrs);
    } else if (days <= 7) {
      final dy = short ? 'dy' : 'day';
      return '\$days \$dy'.pluralize(count: days);
    } else if (weeks <= 4) {
      final wk = short ? 'wk' : 'week';
      return '\$weeks \$wk'.pluralize(count: weeks);
    } else if (months <= 12) {
      final mth = short ? 'mth' : 'month';
      return '\$months \$mth'.pluralize(count: months);
    } else {
      final yr = short ? 'yr' : 'year';
      return '\$yrs \$yr'.pluralize(count: yrs);
    }
  }

  String formatDuration({DateTime? value}) {
    final date = toLocal();
    final now = value ?? DateTime.now().toLocal();
    final duration = now.difference(date).abs();
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    final parts = <String>[];
    if (hours > 0) {
      parts.add('\$hours hr'.pluralize(count: hours));
    }
    if (minutes > 0) {
      parts.add('\$minutes min'.pluralize(count: minutes));
    }
    if (seconds > 0 && hours == 0) {
      parts.add('\$seconds sec'.pluralize(count: seconds));
    }
    return parts.join(' ');
  }

  DateTime nextDay() {
    final date = this;
    final res = date.copyWith(day: date.day + 1);
    return res;
  }

  DateTime previousDay() {
    final date = this;
    final res = date.copyWith(day: date.day - 1);
    return res;
  }

  DateTime forwardInfinity() {
    return add(const Duration(days: 365 * 100000));
  }

  DateTime backwardInfinity() {
    return subtract(const Duration(days: 365 * 100000));
  }
}
""";
