import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import '../generators/project_generator.dart';
import '../utils/logger.dart';
import '../utils/validation.dart';
import 'base_command.dart';

ArgParser initCommandParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for init command',
      negatable: false,
    )
    
    ..addOption(
      'org',
      help: 'Organization identifier (e.g., com.example)',
      defaultsTo: 'com.petracore',
    )
    ..addOption(
      'description',
      help: 'Project description',
      defaultsTo: 'A new Flutter project built with PetraCore architecture.',
    )
    ..addFlag(
      'force',
      help: 'Force creation even if directory exists',
      negatable: false,
    );
}

class InitCommand extends BaseCommand {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize a new Flutter project with PetraCore architecture';

  @override
  Future<void> run(ArgResults results) async {
    if (results['help'] == true) {
      _printHelp();
      return;
    }

    final projectName = results.rest.isNotEmpty ? results.rest.first : null;
    
    if (projectName == null) {
      Logger.error('Project name is required');
      _printHelp();
      exit(1);
    }

    if (!Validation.isValidDartPackageName(projectName)) {
      Logger.error('Invalid project name: $projectName');
      Logger.info('Project name must be a valid Dart package name (lowercase, underscores only)');
      exit(1);
    }

    final projectPath = path.join(Directory.current.path, projectName);
    final projectDir = Directory(projectPath);

    if (projectDir.existsSync() && results['force'] != true) {
      Logger.error('Directory $projectName already exists. Use --force to overwrite.');
      exit(1);
    }

    Logger.header('🏗️  Creating PetraCore Flutter Project: $projectName');

    final config = ProjectConfig(
      projectName: projectName,
      organization: results['org'] as String,
      description: results['description'] as String,
      
      projectPath: projectPath,
    );

    final generator = ProjectGenerator(config);
    
    try {
      await generator.generate();
      
      Logger.success('🎉 Project created successfully!');
      Logger.info('');
      Logger.info('Next steps:');
      Logger.info('  cd $projectName');
      Logger.info('  flutter pub get');
      
      
      
      Logger.info('  flutter run');
      
    } catch (e) {
      Logger.error('Failed to create project: $e');
      exit(1);
    }
  }

  void _printHelp() {
    print('''
Initialize a new Flutter project with PetraCore architecture

Usage: petracore init <project_name> [options]


  --org             Organization identifier (default: com.petracore)
  --description     Project description
  --force           Force creation even if directory exists
  --help, -h        Show this help

Examples:
  petracore init my_awesome_app
  petracore init my_app --org com.mycompany --no-firebase
  petracore init test_app --force --description "A test application"
''');
  }
}
