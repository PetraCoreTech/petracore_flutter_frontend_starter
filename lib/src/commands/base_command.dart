import 'package:args/args.dart';

/// Abstract base class for all CLI commands.
///
/// Subclasses must implement [run], [description], and [name] to define
/// executable command behavior for the PetraCore CLI toolchain.
abstract class BaseCommand {
  /// Executes the command with the given parsed [results].
  Future<void> run(ArgResults results);

  /// A human-readable description of what this command does.
  String get description;

  /// The CLI name used to invoke this command (e.g. `"init"`, `"auth"`).
  String get name;
}
