import 'dart:io';
import 'logger.dart';

/// Utilities for running shell and Flutter CLI commands.
class CommandUtils {
  /// Executes a shell [command] with the given [arguments] and returns the
  /// [ProcessResult].
  ///
  /// [workingDirectory]: optional working directory for the process.
  /// [showOutput]: when `true`, stdout is printed to the console.
  /// [throwOnError]: when `true`, throws [ProcessException] on non-zero exit.
  static Future<ProcessResult> runCommand(
    String command,
    List<String> arguments, {
    String? workingDirectory,
    bool showOutput = false,
    bool throwOnError = true,
  }) async {
    Logger.verbose('Running: $command ${arguments.join(' ')}');

    if (workingDirectory != null) {
      Logger.verbose('Working directory: $workingDirectory');
    }

    final result = await Process.run(
      command,
      arguments,
      workingDirectory: workingDirectory,
    );

    if (showOutput && result.stdout.toString().isNotEmpty) {
      print(result.stdout);
    }

    if (result.stderr.toString().isNotEmpty) {
      Logger.verbose('stderr: ${result.stderr}');
    }

    if (throwOnError && result.exitCode != 0) {
      throw ProcessException(
        command,
        arguments,
        'Command failed with exit code ${result.exitCode}\n'
        'stdout: ${result.stdout}\n'
        'stderr: ${result.stderr}',
        result.exitCode,
      );
    }

    Logger.verbose('Command completed with exit code: ${result.exitCode}');
    return result;
  }

  /// Returns `true` if [command] is available on the system PATH.
  static Future<bool> isCommandAvailable(String command) async {
    try {
      final result = await Process.run(
        Platform.isWindows ? 'where' : 'which',
        [command],
      );
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  /// Runs `dart` with the given [arguments]. Delegates to [runCommand].
  ///
  /// [workingDirectory]: optional working directory for the process.
  /// [showOutput]: when `true`, stdout is printed to the console.
  /// [throwOnError]: when `true`, throws [ProcessException] on non-zero exit.
  static Future<ProcessResult> runDartCommand(
    List<String> arguments, {
    String? workingDirectory,
    bool showOutput = false,
    bool throwOnError = true,
  }) async {
    return runCommand(
      'dart',
      arguments,
      workingDirectory: workingDirectory,
      showOutput: showOutput,
      throwOnError: throwOnError,
    );
  }

  /// Runs `flutter` with the given [arguments]. Delegates to [runCommand].
  ///
  /// [workingDirectory]: optional working directory for the process.
  /// [showOutput]: when `true`, stdout is printed to the console.
  /// [throwOnError]: when `true`, throws [ProcessException] on non-zero exit.
  static Future<ProcessResult> runFlutterCommand(
    List<String> arguments, {
    String? workingDirectory,
    bool showOutput = false,
    bool throwOnError = true,
  }) async {
    return runCommand(
      'flutter',
      arguments,
      workingDirectory: workingDirectory,
      showOutput: showOutput,
      throwOnError: throwOnError,
    );
  }
}
