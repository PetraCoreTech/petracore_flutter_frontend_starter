import 'dart:io';

class Logger {
  static bool _verbose = false;

  static void enableVerbose() {
    _verbose = true;
  }

  static void info(String message) {
    stdout.writeln(message);
  }

  static void success(String message) {
    stdout.writeln('✓ $message');
  }

  static void warning(String message) {
    stdout.writeln('⚠ $message');
  }

  static void error(String message) {
    stderr.writeln('✗ $message');
  }

  static void verbose(String message) {
    if (_verbose) {
      stdout.writeln('  $message');
    }
  }

  static void step(String message) {
    stdout.writeln('→ $message');
  }

  static void header(String message) {
    final border = '═' * (message.length + 4);
    stdout.writeln('');
    stdout.writeln('  $border');
    stdout.writeln('  │ $message │');
    stdout.writeln('  $border');
    stdout.writeln('');
  }

  /// Add a blank line for spacing
  static void spacer() {
    stdout.writeln('');
  }

  /// Print a section title with subtle styling
  static void section(String title) {
    stdout.writeln('');
    stdout.writeln('── $title ──');
  }

  /// Print an indented item (useful for lists)
  static void item(String message, {int indent = 2}) {
    final spaces = ' ' * indent;
    stdout.writeln('$spaces• $message');
  }

  /// Print a key-value pair with consistent formatting
  static void keyValue(String key, String value) {
    stdout.writeln('$key: $value');
  }
}
