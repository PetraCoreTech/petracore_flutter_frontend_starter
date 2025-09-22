import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import '../generators/auth_flow_generator.dart';
import '../utils/logger.dart';
import 'base_command.dart';

ArgParser authCommandParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help for auth command',
      negatable: false,
    )
    ..addFlag(
      'login',
      help: 'Include login functionality',
      defaultsTo: true,
    )
    ..addFlag(
      'signup',
      help: 'Include signup functionality',
      defaultsTo: true,
    )
    ..addFlag(
      'email-verification',
      help: 'Include email verification',
      defaultsTo: false,
    )
    ..addFlag(
      'forgot-password',
      help: 'Include forgot password functionality',
      defaultsTo: false,
    )
    ..addFlag(
      'phone-verification',
      help: 'Include phone verification',
      defaultsTo: false,
    )
    ..addFlag(
      'otp',
      help: 'Include OTP (One-Time Password) functionality',
      defaultsTo: false,
    )
    ..addFlag(
      'social-auth',
      help: 'Include social authentication placeholders',
      defaultsTo: false,
    )
    ..addFlag(
      'device-token',
      help: 'Include device token support for push notifications',
      defaultsTo: false,
    )
    ..addFlag(
      'interactive',
      abbr: 'i',
      help: 'Use interactive mode to select features',
      defaultsTo: true,
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'Output directory (default: current directory)',
    );
}

class AuthCommand extends BaseCommand {
  @override
  String get name => 'auth';

  @override
  String get description =>
      'Generate complete authentication flow with clean architecture';

  @override
  Future<void> run(ArgResults results) async {
    if (results['help'] == true) {
      _printHelp();
      return;
    }

    // Check if we're in a Flutter project (if generating in current directory)
    final outputDir = results['output'] as String? ?? Directory.current.path;

    if (results['output'] == null &&
        !File(path.join(outputDir, 'pubspec.yaml')).existsSync()) {
      Logger.error('Not in a Flutter project directory');
      Logger.info(
          'Run this command from the root of your Flutter project or specify --output directory');
      exit(1);
    }

    // Check if auth feature already exists
    final authPath = path.join(outputDir, 'lib', 'features', 'auth');
    if (Directory(authPath).existsSync()) {
      Logger.warning('Auth feature already exists in $authPath');
      stdout.write('Do you want to overwrite it? (y/N): ');
      final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
      if (input != 'y' && input != 'yes') {
        Logger.info('Operation cancelled');
        exit(0);
      }
    }

    AuthFlowConfig config;

    if (results['interactive'] == true) {
      // Interactive mode - ask user what they want
      config = await AuthFlowGenerator.createInteractiveConfig(outputDir);
    } else {
      // Non-interactive mode - use command-line flags
      final projectName = path.basename(outputDir);
      config = AuthFlowConfig(
        projectName: projectName,
        outputPath: outputDir,
        includeLogin: results['login'] as bool,
        includeSignup: results['signup'] as bool,
        includeForgotPassword: results['forgot-password'] as bool,
        includeOtp: results['otp'] as bool,
        includeSocialAuth: results['social-auth'] as bool,
        includeDeviceToken: results['device-token'] as bool,
      );
    }

    Logger.header('Generating Auth Flow');
    _logSelectedFeatures(config);

    final generator = AuthFlowGenerator(config);

    try {
      await generator.generate();

      Logger.success('Authentication flow created successfully!');
      _printPostGenerationInstructions(config);
    } catch (e) {
      Logger.error('Failed to generate auth flow: $e');
      exit(1);
    }
  }

  void _logSelectedFeatures(AuthFlowConfig config) {
    Logger.section('Selected features');
    if (config.includeLogin) Logger.item('Login');
    if (config.includeSignup) Logger.item('Signup');
    if (config.includeForgotPassword) Logger.item('Forgot Password');
    if (config.includeOtp) Logger.item('OTP functionality');
    if (config.includeSocialAuth) Logger.item('Social Auth placeholders');
    if (config.includeDeviceToken) Logger.item('Device Token support');
    Logger.spacer();
  }

  void _printPostGenerationInstructions(AuthFlowConfig config) {
    Logger.info('');
    Logger.info('Generated files:');
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

    Logger.info('Next steps:');
    Logger.info('  1. Add required dependencies to pubspec.yaml:');
    Logger.info('     - flutter_bloc');
    Logger.info('     - dartz');
    Logger.info('     - dio');
    Logger.info('     - flutter_secure_storage');
    Logger.info('     - json_annotation');
    Logger.info('');
    Logger.info('  2. Add dev_dependencies:');
    Logger.info('     - build_runner');
    Logger.info('     - json_serializable');
    Logger.info('');
    Logger.info('  3. Run code generation:');
    Logger.info('     flutter packages pub run build_runner build');
    Logger.info('');
    Logger.info('  4. Update your main BlocProvider to include AuthBloc');
    Logger.info('  5. Add auth routes to your navigation system');
    Logger.info('  6. Configure your API base URL in environment variables');
    Logger.info('');
    Logger.info('Pro tip: Check the generated files for TODO comments');
    Logger.info('   that need your attention for full integration.');
  }

  void _printHelp() {
    print('''
Generate complete authentication flow with clean architecture

Usage: 
  petracore auth [options]

Options:
  --login                 Include login functionality (default: true)
  --signup                Include signup functionality (default: true)
  --email-verification    Include email verification (default: false)
  --forgot-password       Include forgot password functionality (default: false)
  --phone-verification    Include phone verification (default: false)
  --otp                   Include OTP functionality (default: false)
  --social-auth           Include social auth placeholders (default: false)
  --device-token          Include device token support (default: false)
  --interactive, -i       Use interactive mode (default: true)
  --output, -o            Output directory (default: current directory)
  --help, -h              Show this help

Examples:
  petracore auth                                    # Interactive mode
  petracore auth --no-interactive --forgot-password --email-verification
  petracore auth -o /path/to/project --social-auth

The auth flow includes:
  - Complete BLoC state management
  - Clean architecture (data/domain/presentation)
  - Secure token storage
  - Network service integration
  - Email/Phone verification (optional)
  - Password reset (optional)
  - OTP support (optional)

Generated structure follows your lena_core patterns with:
  - DTOs for API communication
  - Repository pattern
  - Use cases for business logic
  - BLoC for state management
  - Ready-to-use UI screens
''');
  }
}
