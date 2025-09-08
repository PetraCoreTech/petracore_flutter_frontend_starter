import 'dart:io';

class Logger {
  static bool _verbose = false;

  static void enableVerbose() {
    _verbose = true;
  }

  static void info(String message) {
    stdout.writeln('ℹ️  $message');
  }

  static void success(String message) {
    stdout.writeln('✅ $message');
  }

  static void warning(String message) {
    stdout.writeln('⚠️  $message');
  }

  static void error(String message) {
    stderr.writeln('❌ $message');
  }

  static void verbose(String message) {
    if (_verbose) {
      stdout.writeln('🔍 $message');
    }
  }

  static void step(String message) {
    stdout.writeln('🔄 $message');
  }

  static void header(String message) {
    final border = '=' * message.length;
    stdout.writeln('\n$border');
    stdout.writeln(message);
    stdout.writeln(border);
  }
}
