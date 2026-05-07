import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/logger.dart';

void main() {
  group('Logger', () {
    late List<String> stdoutLogs;
    late List<String> stderrLogs;

    setUp(() {
      stdoutLogs = [];
      stderrLogs = [];
      // Reset log level before each test
      Logger.setLogLevel(LogLevel.info);
    });

    // Helper function to run tests with mocked stdout/stderr
    Future<void> runWithMockIO(Future<void> Function() testFn) async {
      await IOOverrides.runZoned(
        () async {
          await testFn();
        },
        stdout: () => _MockStdout(stdoutLogs),
        stderr: () => _MockStdout(stderrLogs), // Stderr is also a Stdout
      );
    }

    test('info logs to stdout with INFO prefix and white color', () async {
      await runWithMockIO(() async {
        Logger.info('This is an info message');
        expect(stdoutLogs.first, contains('\x1B[37m[INFO] This is an info message\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('success logs to stdout with checkmark and green color', () async {
      await runWithMockIO(() async {
        Logger.success('Operation successful');
        expect(stdoutLogs.first, contains('\x1B[32m✓ Operation successful\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('warning logs to stdout with WARN prefix and yellow color', () async {
      await runWithMockIO(() async {
        Logger.warning('Something might be wrong');
        expect(stdoutLogs.first, contains('\x1B[33m[WARN] Something might be wrong\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('error logs to stderr with ERROR prefix and red color', () async {
      await runWithMockIO(() async {
        Logger.error('An error occurred');
        expect(stderrLogs.first, contains('\x1B[31m[ERROR] An error occurred\x1B[0m'));
        expect(stdoutLogs, isEmpty);
      });
    });

    test('debug logs to stdout with DEBUG prefix and blue color when log level is debug', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.debug);
        Logger.debug('Debug message');
        expect(stdoutLogs.first, contains('\x1B[34m[DEBUG] Debug message\x1B[0m'));
      });
    });

    test('debug does not log when log level is info', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.info);
        Logger.debug('Debug message');
        expect(stdoutLogs, isEmpty);
      });
    });

    test('verbose logs to stdout with indentation and gray color when log level is verbose', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.verbose);
        Logger.verbose('Verbose output');
        expect(stdoutLogs.first, contains('\x1B[90m  Verbose output\x1B[0m'));
      });
    });

    test('verbose does not log when log level is info', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.info);
        Logger.verbose('Verbose output');
        expect(stdoutLogs, isEmpty);
      });
    });

    test('step logs to stdout with arrow and cyan color', () async {
      await runWithMockIO(() async {
        Logger.step('Performing step');
        expect(stdoutLogs.first, contains('\x1B[36m→ Performing step\x1B[0m'));
      });
    });

    test('header logs to stdout with magenta color and border', () async {
      await runWithMockIO(() async {
        Logger.header('Test Header');
        expect(stdoutLogs[1], contains('\x1B[35m  ═══════════════\x1B[0m')); // Top border
        expect(stdoutLogs[2], contains('\x1B[35m  │ Test Header │\x1B[0m')); // Message
        expect(stdoutLogs[3], contains('\x1B[35m  ═══════════════\x1B[0m')); // Bottom border
      });
    });

    test('section logs to stdout with cyan color and dashes', () async {
      await runWithMockIO(() async {
        Logger.section('Test Section');
        expect(stdoutLogs[1], contains('\x1B[36m── Test Section ──\x1B[0m'));
      });
    });

    test('item logs to stdout with specified indent', () async {
      await runWithMockIO(() async {
        Logger.item('List item', indent: 4);
        expect(stdoutLogs.first, contains('    List item'));
      });
    });

    test('keyValue logs to stdout with white key and cyan value', () async {
      await runWithMockIO(() async {
        Logger.keyValue('Key', 'Value');
        expect(stdoutLogs.first, contains('\x1B[37mKey:\x1B[0m \x1B[36mValue\x1B[0m'));
      });
    });

    test('setLogLevel changes the logging threshold', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.warning);
        Logger.info('This should not be logged');
        Logger.warning('This should be logged');
        expect(stdoutLogs, isNot(contains(contains('This should not be logged'))));
        expect(stdoutLogs.first, contains('\x1B[33m[WARN] This should be logged\x1B[0m'));
      });
    });
  });
}

class _MockStdout implements Stdout {
  final List<String> _logs;
  _MockStdout(this._logs);

  @override
  Encoding encoding = utf8;

  @override
  bool get hasTerminal => false;

  @override
  bool get supportsAnsiEscapes => false;

  @override
  int get terminalColumns => 80;

  @override
  int get terminalLines => 24;

  @override
  void write(Object? object) {
    _logs.add(object.toString());
  }

  @override
  void writeAll(Iterable<dynamic> objects, [String separator = '']) {
    _logs.add(objects.join(separator));
  }

  @override
  void writeCharCode(int charCode) {
    _logs.add(String.fromCharCode(charCode));
  }

  @override
  void writeln([Object? object = '']) {
    _logs.add(object.toString());
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> flush() async {}

  @override
  Future<void> add(List<int> data) async {}

  @override
  Future<void> addError(Object error, [StackTrace? stackTrace]) async {}

  @override
  Future<void> addStream(Stream<List<int>> stream) async => stream.forEach(add);

  @override
  Future<void> get done => Future.value();

  @override
  IOSink get nonBlocking => this; // Return itself as a non-blocking sink

  @override
  String get lineTerminator => '\n';

  @override
  set lineTerminator(String lineTerminator) {
    // Do nothing
  }
}