#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:petracore_flutter_frontend_starter/src/commands/commands.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/logger.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help information',
      negatable: false,
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enable verbose output',
      negatable: false,
    );

  // Add subcommands
  parser.addCommand('init', initCommandParser());
  parser.addCommand('generate', generateCommandParser());
  parser.addCommand('feature', featureCommandParser());
  parser.addCommand('auth', authCommandParser());
  parser.addCommand('service', serviceCommandParser());

  try {
    final results = parser.parse(arguments);

    // Set logging level
    if (results['verbose'] == true) {
      Logger.setLogLevel(LogLevel.verbose);
    }

    if (results['help'] == true || results.command == null) {
      _printHelp(parser);
      exit(0);
    }

    // Route to appropriate command
    switch (results.command!.name) {
      case 'init':
        await InitCommand().run(results.command!);
        break;
      case 'generate':
      case 'feature':
        await FeatureCommand().run(results.command!);
        break;
      case 'auth':
        await AuthCommand().run(results.command!);
        break;
      case 'service':
        await ServiceCommand().run(results.command!);
        break;
      default:
        Logger.error('Unknown command: ${results.command!.name}');
        _printHelp(parser);
        exit(1);
    }
  } catch (e) {
    Logger.error('Error: $e');
    exit(1);
  }
}

void _printHelp(ArgParser parser) {
  print('''
PetraCore Flutter Frontend Starter

A powerful CLI tool for generating Flutter projects with clean architecture,
Firebase integration, and industry best practices.

Usage: petracore <command> [arguments]

Available commands:
  init       Initialize a new Flutter project with PetraCore architecture
  generate   Generate various components (alias: feature)
  feature    Generate a new feature module
  auth       Generate complete authentication flow with login, signup, and more
  service    Bootstrap a new service within an existing feature

Global options:
${parser.usage}

Examples:
  petracore init my_app                    # Create new project
  petracore init my_app --firebase         # Create project with Firebase
  petracore feature auth                   # Detects auth keyword, offers full flow
  petracore auth                           # Generate complete auth flow
  petracore generate feature profile       # Generate profile feature
  petracore service payment                # Bootstrap a payment service in a feature

For more help on a specific command:
  petracore <command> --help
''');
}
