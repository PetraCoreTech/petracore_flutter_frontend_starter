import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import '../generators/auth_flow_generator.dart';
import '../generators/feature_generator.dart';
import '../generators/notification_generator.dart';
import '../generators/project_generator.dart';
import '../utils/logger.dart';
import '../utils/project_config_reader.dart';
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
      help: 'Design preset for visual language',
      defaultsTo: 'default',
      allowed: [
        'default',
        'vercel',
        'airbnb',
        'apple',
        'spotify',
        'vibrant',
        'highContrast',
        'starbucks',
        'linear',
        'notion',
        'mongodb',
        'raycast',
      ],
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
    )
    ..addFlag(
      'no-notifications',
      help: 'Skip notification feature generation',
      defaultsTo: false,
      negatable: false,
    );
}

/// Command that initializes a new Flutter project with the full PetraCore
/// architecture, including directory structure, core files, navigation,
/// optional auth flow, and a selected design preset.
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

    final skipNotifications = results['no-notifications'] as bool;

    final config = ProjectConfig(
      projectName: projectName,
      organization: results['org'] as String,
      description: results['description'] as String,
      projectPath: projectPath,
      designPreset: _parseDesignPreset(presetValue),
    );

    await _generateProject(config);

    if (!skipNotifications) {
      await _generateNotificationFeature(projectName, projectPath);
    }

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

  String _parseDesignPreset(String value) {
    const known = [
      'default', 'vercel', 'airbnb', 'apple', 'spotify', 'vibrant',
      'highContrast', 'starbucks', 'linear', 'notion', 'mongodb', 'raycast',
    ];
    if (known.contains(value)) return value;
    return 'default';
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
    final presets = [
      ('default', 'Default PetraCore', 'PetraCore default design language — balanced, clean, and modern.'),
      ('vercel', 'Vercel-inspired', 'Monochrome precision with restrained accent usage, tight radii, and crisp typography.'),
      ('airbnb', 'Airbnb-inspired', 'Warm rounded consumer interface with generous spacing and approachable surfaces.'),
      ('apple', 'Apple-inspired', 'San Francisco typography and clean, translucent surfaces with minimal ornament.'),
      ('spotify', 'Spotify-inspired', 'Green-on-dark, media-centric visual style with vibrant accents.'),
      ('vibrant', 'Vibrant', 'More saturated palettes, higher chroma, and slightly denser visual rhythm.'),
      ('highContrast', 'High Contrast', 'Maximum readability with strong color contrast and clear visual hierarchy.'),
      ('starbucks', 'Starbucks-inspired', 'Warm neutrals with layered green palette and cozy interface feel.'),
      ('linear', 'Linear-inspired', 'Precise dark interface with lavender accent and clean typographic hierarchy.'),
      ('notion', 'Notion-inspired', 'Calm neutral canvas with restrained blue accents and clean typography.'),
      ('mongodb', 'MongoDB-inspired', 'Developer-focused green palette with dark surfaces and technical feel.'),
      ('raycast', 'Raycast-inspired', 'Utility-dark shell with crisp neutrals and functional minimalism.'),
    ];
    for (var i = 0; i < presets.length; i++) {
      final p = presets[i];
      final defaultLabel = i == 0 ? ' (default)' : '';
      Logger.item('${i + 1}. ${p.$2}$defaultLabel');
      Logger.item(p.$3, indent: 4);
    }
    Logger.spacer();

    stdout.write('Select preset (1-${presets.length}, default: 1): ');
    final input = stdin.readLineSync()?.trim() ?? '';
    final index = int.tryParse(input);
    if (index != null && index >= 1 && index <= presets.length) {
      final selected = presets[index - 1];
      Logger.info('Selected: ${selected.$2}\n');
      return selected.$1;
    }
    Logger.info('Selected: ${presets[0].$2}\n');
    return presets[0].$1;
  }

  Future<void> _generateNotificationFeature(String projectName, String projectPath) async {
    final projectConfig = ProjectConfigReader.createDefaultConfig(
      projectName: projectName,
      projectPath: projectPath,
    );
    final config = FeatureConfig(
      featureName: 'notification',
      projectRoot: projectPath,
      featureRoot: path.join(projectPath, 'lib/features/notification'),
      projectConfig: projectConfig,
    );
    final generator = NotificationGenerator(config);
    await generator.generate();
  }

  void _printHelp() {
    print('''
Initialize a new Flutter project with PetraCore architecture

Usage: petracore init <project_name> [options]


  --org               Organization identifier (default: com.petracore)
  --description       Project description
  --design-preset     Design preset (default: default)
                      Options: default, vercel, airbnb, apple, spotify,
                      vibrant, highContrast, starbucks, linear, notion,
                      mongodb, raycast
  --force             Force creation even if directory exists
  --no-interactive    Skip interactive prompts (use defaults or flags)
  --include-auth      Generate auth feature alongside the project
  --no-notifications  Skip notification feature generation (included by default)
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
