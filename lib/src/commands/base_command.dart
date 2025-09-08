import 'package:args/args.dart';

abstract class BaseCommand {
  Future<void> run(ArgResults results);

  String get description;

  String get name;
}
