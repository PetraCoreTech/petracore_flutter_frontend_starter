import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import '../generators/auth_flow_generator.dart';
import '../generators/feature_generator.dart';
import '../utils/logger.dart';
import '../utils/project_config_reader.dart';
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

    // 🔐 AUTH KEYWORD ANALYSIS - Check if user wants full auth flow
    if (featureName.toLowerCase() == 'auth') {
      await _handleAuthKeyword();
      return;
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

    Logger.step('Reading project configuration...');
    final projectConfig = await ProjectConfigReader.readOrDefault();

    final config = FeatureConfig(
      featureName: featureName,
      outputPath: featurePath,
      includeBloc: featureResults['bloc'] as bool,
      includeRepository: featureResults['repository'] as bool,
      includeUseCases: featureResults['use-cases'] as bool,
      includeModels: featureResults['models'] as bool,
      projectConfig: projectConfig,
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

  /// Handle the 'auth' keyword specially - offer full auth flow
  Future<void> _handleAuthKeyword() async {
    Logger.header('🔐 Auth Feature Detected!');
    Logger.info('');
    Logger.info('I detected you want to generate an "auth" feature.');
    Logger.info('Would you like to:');
    Logger.info('');
    Logger.info(
        '  1. 📦 Generate a basic auth feature (standard feature structure)');
    Logger.info('  2. 🚀 Bootstrap complete authentication flow (recommended)');
    Logger.info('      • Login & Signup screens');
    Logger.info('      • BLoC state management');
    Logger.info('      • Repository & Use Cases');
    Logger.info('      • DTOs & Models');
    Logger.info('      • Token storage & refresh');
    Logger.info('      • Network service integration');
    Logger.info('      • Optional: Email verification, OTP, etc.');
    Logger.info('');

    stdout.write('Choose option (1 or 2, default: 2): ');
    final input = stdin.readLineSync()?.trim() ?? '';

    if (input == '1') {
      Logger.info('\nGenerating basic auth feature...');
      await _generateBasicAuthFeature();
    } else {
      Logger.info('\n🎉 Great choice! Let\'s set up a complete auth flow.');
      Logger.info('');
      await _generateFullAuthFlow();
    }
  }

  /// Generate a basic auth feature using the standard feature generator
  Future<void> _generateBasicAuthFeature() async {
    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final outputDir = 'lib/features';
    final featurePath = path.join(outputDir, 'auth');

    if (Directory(featurePath).existsSync()) {
      Logger.error('Feature auth already exists in $featurePath');
      exit(1);
    }

    Logger.header('🚀 Generating Basic Auth Feature');

    // Read project configuration
    Logger.step('Reading project configuration...');
    final projectConfig = await ProjectConfigReader.readOrDefault();

    final config = FeatureConfig(
      featureName: 'auth',
      outputPath: featurePath,
      includeBloc: true,
      includeRepository: true,
      includeUseCases: true,
      includeModels: true,
      projectConfig: projectConfig,
    );

    final generator = FeatureGenerator(config);

    try {
      await generator.generate();

      Logger.success('✨ Basic auth feature created successfully!');
      Logger.info('');
      Logger.info('Generated files:');
      Logger.info('  📁 $featurePath/');
      Logger.info('  📄 auth_index.dart');
      Logger.info('  📁 data/ (models, repositories, use cases)');
      Logger.info('  📁 presentation/ (screens, controllers)');
      Logger.info('');
      Logger.info('Next steps:');
      Logger.info('  1. Add the feature to your main bloc provider');
      Logger.info('  2. Update your navigation routes');
      Logger.info('  3. Run: flutter packages pub run build_runner build');
      Logger.info('');
      Logger.info('💡 Tip: Run "petracore auth" for a complete auth flow with');
      Logger.info('   login/signup screens, token management, and more!');
    } catch (e) {
      Logger.error('Failed to generate basic auth feature: $e');
      exit(1);
    }
  }

  /// Generate the full authentication flow
  Future<void> _generateFullAuthFlow() async {
    // Check if we're in a Flutter project
    if (!File('pubspec.yaml').existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info('Run this command from the root of your Flutter project');
      exit(1);
    }

    final currentDir = Directory.current.path;

    // Check if auth feature already exists
    final authPath = path.join(currentDir, 'lib', 'features', 'auth');
    if (Directory(authPath).existsSync()) {
      Logger.warning('Auth feature already exists in $authPath');
      stdout.write('Do you want to overwrite it? (y/N): ');
      final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
      if (input != 'y' && input != 'yes') {
        Logger.info('Operation cancelled');
        exit(0);
      }
    }

    // Use the interactive config from AuthFlowGenerator
    final config = await AuthFlowGenerator.createInteractiveConfig(currentDir);

    Logger.header('🚀 Generating Complete Auth Flow');
    _logSelectedFeatures(config);

    final generator = AuthFlowGenerator(config);

    try {
      await generator.generate();

      Logger.success('✨ Complete authentication flow created successfully!');
      _printAuthFlowPostInstructions(config);
    } catch (e) {
      Logger.error('Failed to generate auth flow: $e');
      exit(1);
    }
  }

  void _logSelectedFeatures(AuthFlowConfig config) {
    Logger.info('Selected features:');
    if (config.includeLogin) Logger.info('  ✅ Login');
    if (config.includeSignup) Logger.info('  ✅ Signup');
    if (config.includeEmailVerification) Logger.info('  ✅ Email Verification');
    if (config.includeForgotPassword) Logger.info('  ✅ Forgot Password');
    if (config.includePhoneVerification) Logger.info('  ✅ Phone Verification');
    if (config.includeOtp) Logger.info('  ✅ OTP functionality');
    if (config.includeSocialAuth) Logger.info('  ✅ Social Auth placeholders');
    if (config.includeDeviceToken) Logger.info('  ✅ Device Token support');
    Logger.info('');
  }

  void _printAuthFlowPostInstructions(AuthFlowConfig config) {
    Logger.info('');
    Logger.info('📁 Generated complete auth flow:');
    Logger.info('  lib/features/auth/');
    Logger.info('  ├── data/');
    Logger.info('  │   ├── models/          (User model)');
    Logger.info('  │   ├── remote/          (Repository, Service, DTOs)');
    Logger.info('  │   ├── use_case/        (Auth use cases)');
    Logger.info('  │   └── enums/           (Auth enums)');
    Logger.info('  └── presentation/');
    Logger.info('      ├── controllers/     (AuthBloc)');
    Logger.info('      ├── screens/         (Login/Signup screens)');
    Logger.info('      └── helpers/         (Controllers)');
    Logger.info('');

    Logger.info('🔧 Required dependencies:');
    Logger.info('  Add these to pubspec.yaml:');
    Logger.info('  dependencies:');
    Logger.info('    flutter_bloc: ^8.1.3');
    Logger.info('    dartz: ^0.10.1');
    Logger.info('    dio: ^5.3.0');
    Logger.info('    flutter_secure_storage: ^9.0.0');
    Logger.info('    json_annotation: ^4.8.1');
    Logger.info('');
    Logger.info('  dev_dependencies:');
    Logger.info('    build_runner: ^2.4.6');
    Logger.info('    json_serializable: ^6.7.1');
    Logger.info('');
    Logger.info('🚀 Next steps:');
    Logger.info('  1. Run: flutter pub get');
    Logger.info('  2. Run: flutter packages pub run build_runner build');
    Logger.info('  3. Add AuthBloc to your main BlocProvider');
    Logger.info('  4. Add auth routes to your navigation');
    Logger.info('  5. Configure API base URL in environment variables');
    Logger.info('');
    Logger.info('🎉 Your authentication system is ready to use!');
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
  petracore feature auth                   # Detects auth and offers full flow
  petracore feature user_profile --no-bloc
  petracore generate feature chat --output lib/modules

Special Keywords:
  🔐 auth    - Offers to generate complete authentication flow
             including login, signup, BLoC, repository, and more
''');
  }
}
