import 'dart:io';
import 'logger.dart';

class CommandUtils {
  /// Executes a shell command and returns the result
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

  /// Checks if a command is available in the system PATH
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

  /// Runs flutter command with the given arguments
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