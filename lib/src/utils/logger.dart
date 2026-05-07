import 'dart:io';

enum LogLevel {
  debug,
  verbose,
  info,
  step,
  success,
  warning,
  error,
  header,
  section,
  item,
  keyValue,
}

class Logger {
  static LogLevel _currentLogLevel = LogLevel.info;

  static void setLogLevel(LogLevel level) {
    _currentLogLevel = level;
  }

  static void _log(LogLevel level, String message, {int indent = 0}) {
    // For verbose and debug, we check against the current log level directly
    // For other levels, we only log if the level is higher or equal to the current log level
    if ((level == LogLevel.verbose && _currentLogLevel.index > LogLevel.verbose.index) ||
        (level == LogLevel.debug && _currentLogLevel.index > LogLevel.debug.index) ||
        (level.index < _currentLogLevel.index && level != LogLevel.verbose && level != LogLevel.debug)) {
      return;
    }

    String prefix = '';
    String color = '';
    String resetColor = '\x1B[0m'; // ANSI escape code for reset

    switch (level) {
      case LogLevel.debug:
        prefix = '[DEBUG] ';
        color = '\x1B[34m'; // Blue
        break;
      case LogLevel.info:
        prefix = '[INFO] ';
        color = '\x1B[37m'; // White
        break;
      case LogLevel.warning:
        prefix = '[WARN] ';
        color = '\x1B[33m'; // Yellow
        break;
      case LogLevel.error:
        prefix = '[ERROR] ';
        color = '\x1B[31m'; // Red
        break;
      case LogLevel.success:
        prefix = '✓ ';
        color = '\x1B[32m'; // Green
        break;
      case LogLevel.verbose:
        prefix = '  ';
        color = '\x1B[90m'; // Bright Black (Gray)
        break;
      case LogLevel.step:
        prefix = '→ ';
        color = '\x1B[36m'; // Cyan
        break;
      case LogLevel.header:
      case LogLevel.section:
      case LogLevel.item:
      case LogLevel.keyValue:
        // Handled by specific methods, no generic prefix/color here
        break;
    }

    final indentedMessage = '${' ' * indent}$message';
    final output = '$color$prefix$indentedMessage$resetColor';

    if (level == LogLevel.error) {
      stderr.writeln(output);
    } else {
      stdout.writeln(output);
    }
  }

  static void info(String message) {
    _log(LogLevel.info, message);
  }

  static void success(String message) {
    _log(LogLevel.success, message);
  }

  static void warning(String message) {
    _log(LogLevel.warning, message);
  }

  static void error(String message) {
    _log(LogLevel.error, message);
  }

  static void verbose(String message) {
    _log(LogLevel.verbose, message);
  }

  static void debug(String message) {
    _log(LogLevel.debug, message);
  }

  static void step(String message) {
    _log(LogLevel.step, message);
  }

  static void header(String message) {
    final border = '═' * (message.length + 4);
    stdout.writeln('');
    stdout.writeln('\x1B[35m  $border\x1B[0m'); // Magenta
    stdout.writeln('\x1B[35m  │ $message │\x1B[0m');
    stdout.writeln('\x1B[35m  $border\x1B[0m');
    stdout.writeln('');
  }

  /// Add a blank line for spacing
  static void spacer() {
    stdout.writeln('');
  }

  /// Print a section title with subtle styling
  static void section(String title) {
    stdout.writeln('');
    stdout.writeln('\x1B[36m── $title ──\x1B[0m'); // Cyan
  }

  /// Print an indented item (useful for lists)
  static void item(String message, {int indent = 2}) {
    _log(LogLevel.item, message, indent: indent);
  }

  /// Print a key-value pair with consistent formatting
  static void keyValue(String key, String value) {
    stdout.writeln('\x1B[37m$key:\x1B[0m \x1B[36m$value\x1B[0m'); // White key, Cyan value
  }
}
