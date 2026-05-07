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
  String get description =>
      'Initialize a new Flutter project with PetraCore architecture';

  @override
  Future<void> run(ArgResults results) async {
    final projectName = results.rest.isNotEmpty ? results.rest.first : null;
    _validateProjectName(projectName);

    final projectPath = path.join(Directory.current.path, projectName!);
    await _handleProjectDirectory(projectName, projectPath, results['force'] as bool);

    Logger.header('Creating PetraCore Flutter Project: $projectName');

    final config = ProjectConfig(
      projectName: projectName,
      organization: results['org'] as String,
      description: results['description'] as String,
      projectPath: projectPath,
    );

    await _generateProject(config);
  }

  void _validateProjectName(String? projectName) {
    if (projectName == null) {
      Logger.error('Project name is required');
      _printHelp();
      exit(1);
    }

    if (!Validation.isValidDartPackageName(projectName)) {
      Logger.error('Invalid project name: $projectName');
      Logger.info(
          'Project name must be a valid Dart package name (lowercase, underscores only)');
      exit(1);
    }
  }

  Future<void> _handleProjectDirectory(String projectName, String projectPath, bool force) async {
    final projectDir = Directory(projectPath);

    if (projectDir.existsSync()) {
      if (!force) {
        Logger.error(
            'Directory $projectName already exists. Use --force to overwrite.');
        exit(1);
      } else {
        Logger.warning(
            'Directory $projectName exists. Cleaning up for fresh Flutter project creation...');
        try {
          await projectDir.delete(recursive: true);
          Logger.verbose('Deleted existing directory');
        } catch (e) {
          Logger.error('Failed to delete existing directory: $e');
          exit(1);
        }
      }
    }
  }

  Future<void> _generateProject(ProjectConfig config) async {
    final generator = ProjectGenerator(config);

    try {
      await generator.generate();

      Logger.success('Project created successfully!');

      Logger.section('Next steps');
      Logger.item('cd ${config.projectName}');
      Logger.item('flutter pub get  # Get updated dependencies');
      Logger.item(
          'flutter packages pub run build_runner build  # Generate code for models');
      Logger.item('flutter run');
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
