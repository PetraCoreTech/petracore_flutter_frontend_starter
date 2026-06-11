import 'dart:io';

/// Log severity levels used to control which messages [Logger] displays.
enum LogLevel {
  /// Debug-level messages (highest verbosity).
  debug,

  /// Verbose informational messages.
  verbose,

  /// General informational messages.
  info,

  /// Step/progress indicators.
  step,

  /// Success confirmation messages.
  success,

  /// Warning messages.
  warning,

  /// Error messages.
  error,

  /// Section header titles.
  header,

  /// Section sub-titles.
  section,

  /// List items within a section.
  item,

  /// Key-value pair entries.
  keyValue,
}

/// Colored console logger with severity-based filtering and formatting.
/// Supports structured output via [header], [section], [item], [keyValue],
/// and progress tracking via [fileProgress].
class Logger {
  static LogLevel _currentLogLevel = LogLevel.info;

  /// Sets the minimum [LogLevel] for messages to be displayed.
  /// Messages below this level are suppressed.
  static void setLogLevel(LogLevel level) {
    _currentLogLevel = level;
  }

  static bool _shouldLog(LogLevel level) {
    if (level == LogLevel.verbose &&
        _currentLogLevel.index > LogLevel.verbose.index) {
      return false;
    }
    if (level == LogLevel.debug &&
        _currentLogLevel.index > LogLevel.debug.index) {
      return false;
    }
    if (level.index < _currentLogLevel.index &&
        level != LogLevel.verbose &&
        level != LogLevel.debug) {
      return false;
    }
    return true;
  }

  static void _log(LogLevel level, String message, {int indent = 0}) {
    if (!_shouldLog(level)) return;

    String prefix = '';
    String color = '';
    final reset = '\x1B[0m';

    switch (level) {
      case LogLevel.debug:
        prefix = '· ';
        color = '\x1B[34m'; // Blue
        break;
      case LogLevel.info:
        prefix = '  ';
        color = '\x1B[37m'; // White
        break;
      case LogLevel.warning:
        prefix = '▲ ';
        color = '\x1B[33m'; // Yellow
        break;
      case LogLevel.error:
        prefix = '✗ ';
        color = '\x1B[31m'; // Red
        break;
      case LogLevel.success:
        prefix = '✔ ';
        color = '\x1B[32m'; // Green
        break;
      case LogLevel.verbose:
        prefix = '   ';
        color = '\x1B[90m'; // Gray
        break;
      case LogLevel.step:
        prefix = '→ ';
        color = '\x1B[36m'; // Cyan
        break;
      default:
        break;
    }

    final indented = '${' ' * indent}$message';
    final output = '$color$prefix$indented$reset';

    if (level == LogLevel.error) {
      stderr.writeln(output);
    } else {
      stdout.writeln(output);
    }
  }

  /// Logs an informational [message].
  static void info(String message) => _log(LogLevel.info, message);
  /// Logs a success confirmation [message].
  static void success(String message) => _log(LogLevel.success, message);
  /// Logs a warning [message].
  static void warning(String message) => _log(LogLevel.warning, message);
  /// Logs an error [message] to stderr.
  static void error(String message) => _log(LogLevel.error, message);
  /// Logs a verbose informational [message] (gray, lower priority).
  static void verbose(String message) => _log(LogLevel.verbose, message);
  /// Logs a debug-level [message] (blue, highest verbosity).
  static void debug(String message) => _log(LogLevel.debug, message);
  /// Logs a step/progress indicator [message] (cyan, arrow-prefixed).
  static void step(String message) => _log(LogLevel.step, message);

  /// Clean header with a diamond and subtle underline
  static void header(String message) {
    if (!_shouldLog(LogLevel.header)) return;
    final reset = '\x1B[0m';
    final magenta = '\x1B[35m';
    final dim = '\x1B[2m';
    final line = '─' * (message.length + 2);
    stdout.writeln();
    stdout.writeln('$magenta  ◆  $message$reset');
    stdout.writeln('$dim   $line$reset');
    stdout.writeln();
  }

  /// Writes a blank line to stdout.
  static void spacer() => stdout.writeln();

  /// Section title with subtle dot prefix
  static void section(String title) {
    if (!_shouldLog(LogLevel.section)) return;
    final reset = '\x1B[0m';
    final cyan = '\x1B[36m';
    stdout.writeln('$cyan  · $title$reset');
  }

  /// Indented item for lists
  static void item(String message, {int indent = 2}) {
    _log(LogLevel.item, message, indent: indent);
  }

  /// Key-value pair with consistent formatting
  static void keyValue(String key, String value) {
    if (!_shouldLog(LogLevel.keyValue)) return;
    final reset = '\x1B[0m';
    final white = '\x1B[37m';
    final cyan = '\x1B[36m';
    stdout.writeln('$white  $key:$reset $cyan$value$reset');
  }

/// Track and display file generation progress as a compact summary.
/// Call [start] before generating, then [tick] for each file, then [done].
static FileProgress fileProgress(String label) => FileProgress(label);
}

/// Tracks and displays file generation progress as a compact single-line
/// progress indicator.
class FileProgress {
  final String label;
  int _total = 0;
  int _done = 0;
  int _lastOutputLength = 0;

  /// Creates a progress tracker with the given [label].
  FileProgress(this.label);

  /// Starts tracking progress for [total] items and renders the initial line.
  void start(int total) {
    _total = total;
    _done = 0;
    _print();
  }

  /// Advances progress by one item and re-renders the line.
  void tick() {
    _done++;
    _print();
  }

  /// Marks all items as done and writes the final summary line with a
  /// checkmark.
  void done() {
    _done = _total;
    // Clear the progress line
    if (_lastOutputLength > 0) {
      stdout.write('\r${' ' * _lastOutputLength}\r');
    }
    final reset = '\x1B[0m';
    final gray = '\x1B[90m';
    final cyan = '\x1B[36m';
    final green = '\x1B[32m';
    stdout.writeln(
        '$green  ✔$reset $cyan$label$reset $gray(${_done}/$_total files)$reset');
  }

  void _print() {
    final reset = '\x1B[0m';
    final gray = '\x1B[90m';
    final message = '  $label $gray(${_done}/$_total)$reset';
    // Pad to clear previous line
    final padded = message.padRight(_lastOutputLength);
    stdout.write('\r$padded');
    _lastOutputLength = padded.length;
  }
}
