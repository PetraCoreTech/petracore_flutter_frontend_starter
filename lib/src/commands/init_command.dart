import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import '../design_presets/design_preset.dart';
import '../design_presets/design_preset_registry.dart';
import '../generators/auth_flow_generator.dart';
import '../generators/project_generator.dart';
import '../utils/logger.dart';
import '../utils/validation.dart';
import 'base_command.dart';

/// Builds the [ArgParser] for the `init` command, defining options such as
/// [org], [description], [design-preset], [force], [no-interactive], and
/// [include-auth].
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
      'design-preset',
      help: 'Design preset: default (default), vercel, airbnb, or apple',
      defaultsTo: 'default',
      allowed: ['default', 'vercel', 'airbnb', 'apple'],
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
    )
    ..addFlag(
      'include-auth',
      help: 'Generate auth feature alongside the project',
      defaultsTo: false,
      negatable: false,
    );
}

/// Command that initializes a new Flutter project with the full PetraCore
/// architecture, including directory structure, core files, navigation,
/// optional auth flow, and a selected [DesignPreset].
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
    final presetExplicit = results.wasParsed('design-preset');
    final presetValue = (noInteractive || presetExplicit)
        ? results['design-preset'] as String
        : _promptForDesignPreset();

    final authExplicit = results.wasParsed('include-auth');
    final includeAuth = (noInteractive || authExplicit)
        ? results['include-auth'] as bool
        : _promptForAuth();

    final config = ProjectConfig(
      projectName: projectName,
      organization: results['org'] as String,
      description: results['description'] as String,
      projectPath: projectPath,
      designPreset: _parseDesignPreset(presetValue),
    );

    await _generateProject(config);

    if (includeAuth) {
      await _generateAuth(projectName, projectPath);
    }
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

  DesignPresetId _parseDesignPreset(String value) {
    switch (value) {
      case 'vercel':
        return DesignPresetId.vercel;
      case 'airbnb':
        return DesignPresetId.airbnb;
      case 'apple':
        return DesignPresetId.apple;
      default:
        return DesignPresetId.defaultPreset;
    }
  }

  bool _promptForAuth() {
    Logger.section('Auth Feature');
    stdout.write('Generate auth feature alongside the project? (y/N): ');
    final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
    final result = input == 'y' || input == 'yes';
    Logger.info(result ? 'Auth feature will be generated\n' : 'Skipping auth feature\n');
    return result;
  }

  Future<void> _generateAuth(String projectName, String projectPath) async {
    Logger.header('Generating Auth Feature');
    final config = AuthFlowConfig(
      projectName: projectName,
      outputPath: projectPath,
      includeLogin: true,
      includeSignup: true,
      includeEmailVerification: false,
      includePhoneVerification: false,
      includeForgotPassword: true,
      includeOtp: true,
      includeSocialAuth: false,
      includeDeviceToken: false,
      includeWelcomeScreen: true,
      includeSplashScreen: true,
    );
    final generator = AuthFlowGenerator(config);
    await generator.generate();
  }

  String _promptForDesignPreset() {
    Logger.section('Design Preset');
    Logger.info('Choose a design preset:');
    Logger.spacer();
    final presets = DesignPresetRegistry.all;
    for (var i = 0; i < presets.length; i++) {
      final label = i == 0
          ? '${i + 1}. ${presets[i].displayName} (default)'
          : '${i + 1}. ${presets[i].displayName}';
      Logger.item(label);
    }
    Logger.spacer();

    stdout.write('Select preset (1-${presets.length}, default: 1): ');
    final input = stdin.readLineSync()?.trim() ?? '';
    final index = int.tryParse(input);
    if (index != null && index >= 1 && index <= presets.length) {
      final selected = presets[index - 1];
      Logger.info('Selected: ${selected.displayName}\n');
      return selected.id.name;
    }
    Logger.info('Selected: ${presets[0].displayName}\n');
    return presets[0].id.name;
  }

  void _printHelp() {
    print('''
Initialize a new Flutter project with PetraCore architecture

Usage: petracore init <project_name> [options]


  --org               Organization identifier (default: com.petracore)
  --description       Project description
  --design-preset     Design preset: default (default), vercel, airbnb, apple
  --force             Force creation even if directory exists
  --no-interactive    Skip interactive prompts (use defaults or flags)
  --include-auth      Generate auth feature alongside the project
  --help, -h          Show this help

When --design-preset or --include-auth are not specified, you will be prompted
interactively. Use flags or --no-interactive to skip prompts in scripts.

Examples:
  petracore init my_awesome_app
  petracore init my_app --org com.mycompany
  petracore init app_with_vercel --design-preset vercel
  petracore init test_app --force --description "A test application"
  petracore init my_app --no-interactive               # Uses defaults
  petracore init my_app --include-auth                 # With auth feature
''');
  }
}
