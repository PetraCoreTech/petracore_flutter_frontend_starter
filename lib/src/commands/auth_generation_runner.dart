import 'dart:io';

import 'package:path/path.dart' as path;

import '../generators/auth_flow_generator.dart';
import '../utils/logger.dart';

class AuthGenerationOptions {
  AuthGenerationOptions({
    required this.outputDir,
    required this.interactive,
    this.includeLogin = true,
    this.includeSignup = true,
    this.includeEmailVerification = false,
    this.includePhoneVerification = false,
    this.includeForgotPassword = false,
    this.includeOtp = false,
    this.includeSocialAuth = false,
    this.includeDeviceToken = false,
    this.runPostGenerationActions = true,
  });

  final String outputDir;
  final bool interactive;
  final bool includeLogin;
  final bool includeSignup;
  final bool includeEmailVerification;
  final bool includePhoneVerification;
  final bool includeForgotPassword;
  final bool includeOtp;
  final bool includeSocialAuth;
  final bool includeDeviceToken;
  final bool runPostGenerationActions;

  String get resolvedOutputDir => path.normalize(path.absolute(outputDir));
}

class AuthGenerationRunner {
  static Future<void> run(AuthGenerationOptions options) async {
    _validateOptions(options);
    final outputDir = options.resolvedOutputDir;

    if (!File(path.join(outputDir, 'pubspec.yaml')).existsSync()) {
      Logger.error('Not a Flutter project directory: $outputDir');
      Logger.info(
          'Run this command from the root of your Flutter project or specify --output directory');
      exit(1);
    }

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

    if (options.interactive) {
      config = await AuthFlowGenerator.createInteractiveConfig(outputDir);
      config = config.copyWith(
        runPostGenerationActions: options.runPostGenerationActions,
      );
    } else {
      final projectName = path.basename(outputDir);
      config = AuthFlowConfig(
        projectName: projectName,
        outputPath: outputDir,
        includeLogin: options.includeLogin,
        includeSignup: options.includeSignup,
        includeEmailVerification: options.includeEmailVerification,
        includePhoneVerification: options.includePhoneVerification,
        includeForgotPassword: options.includeForgotPassword,
        includeOtp: options.includeOtp,
        includeSocialAuth: options.includeSocialAuth,
        includeDeviceToken: options.includeDeviceToken,
        runPostGenerationActions: options.runPostGenerationActions,
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

  static void _validateOptions(AuthGenerationOptions options) {
    if (options.interactive) {
      return;
    }

    final hasCoreAuthFeature = options.includeLogin ||
        options.includeSignup ||
        options.includeForgotPassword ||
        options.includeOtp ||
        options.includeEmailVerification ||
        options.includePhoneVerification;
    if (!hasCoreAuthFeature) {
      throw ArgumentError(
        'At least one core auth capability must be enabled (login, signup, forgot-password, otp, email-verification, phone-verification).',
      );
    }

    if (options.includeEmailVerification &&
        !options.includeLogin &&
        !options.includeSignup) {
      throw ArgumentError(
        'Email verification requires login or signup to be enabled.',
      );
    }

    if (options.includePhoneVerification &&
        !options.includeLogin &&
        !options.includeSignup) {
      throw ArgumentError(
        'Phone verification requires login or signup to be enabled.',
      );
    }
  }

  static void _logSelectedFeatures(AuthFlowConfig config) {
    Logger.section('Selected features');
    if (config.includeLogin) Logger.item('Login');
    if (config.includeSignup) Logger.item('Signup');
    if (config.includeEmailVerification) Logger.item('Email verification');
    if (config.includePhoneVerification) Logger.item('Phone verification');
    if (config.includeForgotPassword) Logger.item('Forgot Password');
    if (config.includeOtp) Logger.item('OTP functionality');
    if (config.includeSocialAuth) Logger.item('Social Auth placeholders');
    if (config.includeDeviceToken) Logger.item('Device Token support');
    Logger.spacer();
  }

  static void _printPostGenerationInstructions(AuthFlowConfig config) {
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
    Logger.info('     dart run build_runner build');
    Logger.info('');
    Logger.info('  4. Update your main BlocProvider to include AuthBloc');
    Logger.info('  5. Add auth routes to your navigation system');
    Logger.info('  6. Configure your API base URL in environment variables');
    Logger.info('');
    Logger.info('Pro tip: Check the generated files for TODO comments');
    Logger.info('   that need your attention for full integration.');
  }
}
