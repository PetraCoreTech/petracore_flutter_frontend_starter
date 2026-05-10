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
      Logger.setLogLevel(LogLevel.info);
    });

    Future<void> runWithMockIO(Future<void> Function() testFn) async {
      await IOOverrides.runZoned(
        () async {
          await testFn();
        },
        stdout: () => _MockStdout(stdoutLogs),
        stderr: () => _MockStdout(stderrLogs),
      );
    }

    test('info logs to stdout with white color', () async {
      await runWithMockIO(() async {
        Logger.info('info message');
        expect(stdoutLogs.first, contains('\x1B[37m  info message\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('success logs to stdout with green checkmark', () async {
      await runWithMockIO(() async {
        Logger.success('done');
        expect(stdoutLogs.first, contains('\x1B[32m✔ done\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('warning logs to stdout with yellow triangle', () async {
      await runWithMockIO(() async {
        Logger.warning('caution');
        expect(stdoutLogs.first, contains('\x1B[33m▲ caution\x1B[0m'));
        expect(stderrLogs, isEmpty);
      });
    });

    test('error logs to stderr with red X mark', () async {
      await runWithMockIO(() async {
        Logger.error('fail');
        expect(stderrLogs.first, contains('\x1B[31m✗ fail\x1B[0m'));
        expect(stdoutLogs, isEmpty);
      });
    });

    test('debug logs with blue dot when log level is debug', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.debug);
        Logger.debug('debug msg');
        expect(stdoutLogs.first, contains('\x1B[34m· debug msg\x1B[0m'));
      });
    });

    test('debug does not log when log level is info', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.info);
        Logger.debug('debug msg');
        expect(stdoutLogs, isEmpty);
      });
    });

    test('verbose logs in gray when log level is verbose', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.verbose);
        Logger.verbose('verbose output');
        expect(stdoutLogs.first, contains('\x1B[90m   verbose output\x1B[0m'));
      });
    });

    test('verbose does not log when log level is info', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.info);
        Logger.verbose('verbose output');
        expect(stdoutLogs, isEmpty);
      });
    });

    test('step logs to stdout with arrow and cyan color', () async {
      await runWithMockIO(() async {
        Logger.step('Performing step');
        expect(stdoutLogs.first, contains('\x1B[36m→ Performing step\x1B[0m'));
      });
    });

    test('header logs title, spacer and underline', () async {
      await runWithMockIO(() async {
        Logger.header('Test');
        expect(stdoutLogs[0], isEmpty); // spacer
        expect(stdoutLogs[1], contains('\x1B[35m  ◆  Test\x1B[0m'));
        expect(stdoutLogs[2], contains('\x1B[2m   ──────\x1B[0m'));
      });
    });

    test('section logs with dot prefix and cyan', () async {
      await runWithMockIO(() async {
        Logger.section('Section');
        expect(stdoutLogs.first, contains('\x1B[36m  · Section\x1B[0m'));
      });
    });

    test('item logs to stdout with specified indent', () async {
      await runWithMockIO(() async {
        Logger.item('List item', indent: 4);
        expect(stdoutLogs.first, contains('    List item'));
      });
    });

    test('keyValue logs with white key and cyan value', () async {
      await runWithMockIO(() async {
        Logger.keyValue('Key', 'Value');
        expect(stdoutLogs.first, contains('\x1B[37m  Key:\x1B[0m \x1B[36mValue\x1B[0m'));
      });
    });

    test('setLogLevel changes the logging threshold', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.warning);
        Logger.info('should not appear');
        Logger.warning('should appear');
        expect(stdoutLogs, isNot(contains(contains('should not appear'))));
        expect(stdoutLogs.first, contains('\x1B[33m▲ should appear\x1B[0m'));
      });
    });

    test('FileProgress start prints progress line', () async {
      await runWithMockIO(() async {
        Logger.setLogLevel(LogLevel.verbose);
        final p = Logger.fileProgress('Generating');
        p.start(10);
        expect(stdoutLogs.first, contains('Generating'));
      });
    });

    test('FileProgress does not throw', () async {
      final p = Logger.fileProgress('Files');
      p.start(3);
      p.tick();
      p.tick();
      p.done();
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
  IOSink get nonBlocking => this;

  @override
  String get lineTerminator => '\n';

  @override
  set lineTerminator(String lineTerminator) {}
}
