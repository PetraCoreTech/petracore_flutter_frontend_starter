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
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Enable verbose output',
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
    ..addOption(
      'theme',
      help: 'Theme system to use: mix (default) or material',
      defaultsTo: 'mix',
      allowed: ['mix', 'material'],
    )
    ..addFlag(
      'force',
      help: 'Force creation even if directory exists',
      negatable: false,
    )
    ..addFlag(
      'no-interactive',
      help: 'Skip interactive prompts and use defaults',
      defaultsTo: false,
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

    final noInteractive = results['no-interactive'] as bool;
    final themeExplicit = results.wasParsed('theme');
    final themeValue = (noInteractive || themeExplicit)
        ? results['theme'] as String
        : _promptForTheme();

    final config = ProjectConfig(
      projectName: projectName,
      organization: results['org'] as String,
      description: results['description'] as String,
      projectPath: projectPath,
      themeType: _parseThemeType(themeValue),
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

  ThemeType _parseThemeType(String theme) {
    switch (theme) {
      case 'material':
        return ThemeType.material;
      default:
        return ThemeType.mix;
    }
  }

  String _promptForTheme() {
    Logger.section('Theme Selection');
    Logger.info('Choose your theme system:');
    Logger.spacer();
    Logger.item('1. Mix (default) - Design token-based theming with Mix package');
    Logger.item('2. Material - Standard Flutter Material 3 ThemeData');
    Logger.spacer();

    stdout.write('Select theme (1 or 2, default: 1): ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input == '2') {
      Logger.info('Selected: Material theme\n');
      return 'material';
    }
    Logger.info('Selected: Mix theme\n');
    return 'mix';
  }

  void _printHelp() {
    print('''
Initialize a new Flutter project with PetraCore architecture

Usage: petracore init <project_name> [options]


  --org               Organization identifier (default: com.petracore)
  --description       Project description
  --theme             Theme system: mix (default) or material
  --force             Force creation even if directory exists
  --no-interactive    Skip interactive prompts (use defaults or flags)
  --help, -h          Show this help

When --theme is not specified, you will be prompted to choose interactively.
Use --theme or --no-interactive to skip the prompt in scripts.

Examples:
  petracore init my_awesome_app
  petracore init my_app --org com.mycompany --theme material
  petracore init test_app --force --description "A test application"
  petracore init my_app --no-interactive               # Uses default (mix)
''');
  }
}
