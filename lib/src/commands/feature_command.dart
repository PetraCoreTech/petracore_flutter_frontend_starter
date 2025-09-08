import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import '../generators/feature_generator.dart';
import '../utils/logger.dart';
import '../utils/validation.dart';
import 'base_command.dart';

ArgParser featureCommandParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for feature command',
      negatable: false,
    )
    ..addFlag(
      'bloc',
      help: 'Include BLoC/Cubit for state management',
      defaultsTo: true,
    )
    ..addFlag(
      'repository',
      help: 'Include repository pattern',
      defaultsTo: true,
    )
    ..addFlag(
      'use-cases',
      help: 'Include use cases for business logic',
      defaultsTo: true,
    )
    ..addFlag(
      'models',
      help: 'Include data models with JSON serialization',
      defaultsTo: true,
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Output directory (default: lib/features)',
    );
}

ArgParser generateCommandParser() {
  final parser = ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for generate command',
      negatable: false,
    );

  parser.addCommand('feature', featureCommandParser());
  return parser;
}

class FeatureCommand extends BaseCommand {
  @override
  String get name => 'feature';

  @override
  String get description =>
      'Generate a new feature module with clean architecture';

  @override
  Future<void> run(ArgResults results) async {
    if (results['help'] == true) {
      _printHelp();
      return;
    }

    // Handle both 'feature <name>' and 'generate feature <name>' patterns
    String? featureName;
    ArgResults? featureResults = results;

    if (results.command?.name == 'feature') {
      // Called as 'generate feature <name>'
      featureResults = results.command!;
      featureName =
          featureResults.rest.isNotEmpty ? featureResults.rest.first : null;
    } else {
      // Called as 'feature <name>'
      featureName = results.rest.isNotEmpty ? results.rest.first : null;
    }

    if (featureName == null) {
      Logger.error('Feature name is required');
      _printHelp();
      exit(1);
    }

    if (!Validation.isValidFeatureName(featureName)) {
      Logger.error('Invalid feature name: $featureName');
      Logger.info(
          'Feature name must be lowercase with underscores (snake_case)');
      exit(1);
    }

    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final outputDir = featureResults['output'] as String? ?? 'lib/features';
    final featurePath = path.join(outputDir, featureName);

    if (Directory(featurePath).existsSync()) {
      Logger.error('Feature $featureName already exists in $featurePath');
      exit(1);
    }

    Logger.header('🚀 Generating Feature: $featureName');

    final config = FeatureConfig(
      featureName: featureName,
      outputPath: featurePath,
      includeBloc: featureResults['bloc'] as bool,
      includeRepository: featureResults['repository'] as bool,
      includeUseCases: featureResults['use-cases'] as bool,
      includeModels: featureResults['models'] as bool,
    );

    final generator = FeatureGenerator(config);

    try {
      await generator.generate();

      Logger.success('✨ Feature $featureName created successfully!');
      Logger.info('');
      Logger.info('Generated files:');
      Logger.info('  📁 $featurePath/');
      Logger.info('  📄 ${featureName}_index.dart');
      Logger.info('  📁 data/ (models, repositories, use cases)');
      Logger.info('  📁 presentation/ (screens, controllers)');
      Logger.info('');
      Logger.info('Next steps:');
      Logger.info('  1. Add the feature to your main bloc provider');
      Logger.info('  2. Update your navigation routes');
      Logger.info('  3. Run: flutter packages pub run build_runner build');
    } catch (e) {
      Logger.error('Failed to generate feature: $e');
      exit(1);
    }
  }

  void _printHelp() {
    print('''
Generate a new feature module with clean architecture

Usage: 
  petracore feature <feature_name> [options]
  petracore generate feature <feature_name> [options]

Options:
  --bloc           Include BLoC/Cubit for state management (default: true)
  --repository     Include repository pattern (default: true)
  --use-cases      Include use cases for business logic (default: true)
  --models         Include data models with JSON serialization (default: true)
  --output, -o     Output directory (default: lib/features)
  --help, -h       Show this help

Examples:
  petracore feature auth
  petracore feature user_profile --no-bloc
  petracore generate feature chat --output lib/modules
''');
  }
}
