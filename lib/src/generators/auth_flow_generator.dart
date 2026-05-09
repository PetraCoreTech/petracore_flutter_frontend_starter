import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/command_utils.dart';

import '../templates/auth/auth_templates.dart';
import '../utils/project_config_reader.dart';

class AuthFlowConfig {
  final String projectName;
  final String outputPath;

  // Auth features to generate
  final bool includeLogin;
  final bool includeSignup;
  final bool includeEmailVerification;
  final bool includePhoneVerification;
  final bool includeForgotPassword;
  final bool includeOtp;

  // Onboarding screens
  final bool includeSplashScreen;
  final bool includeWelcomeScreen;
  final bool includeGetStartedScreen;

  // Additional options
  final bool includeSocialAuth;
  final bool includeDeviceToken;
  final bool runPostGenerationActions;

  AuthFlowConfig({
    required this.projectName,
    required this.outputPath,
    this.includeLogin = true,
    this.includeSignup = true,
    this.includeEmailVerification = false,
    this.includePhoneVerification = false,
    this.includeForgotPassword = true,
    this.includeOtp = true,
    this.includeSplashScreen = true,
    this.includeWelcomeScreen = true,
    this.includeGetStartedScreen = true,
    this.includeDeviceToken = true,
    this.includeSocialAuth = false,
    this.runPostGenerationActions = true,
  });

  String get className => projectName
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join();

  AuthFlowConfig copyWith({
    String? projectName,
    String? outputPath,
    bool? includeLogin,
    bool? includeSignup,
    bool? includeEmailVerification,
    bool? includePhoneVerification,
    bool? includeForgotPassword,
    bool? includeOtp,
    bool? includeSplashScreen,
    bool? includeWelcomeScreen,
    bool? includeGetStartedScreen,
    bool? includeSocialAuth,
    bool? includeDeviceToken,
    bool? runPostGenerationActions,
  }) {
    return AuthFlowConfig(
      projectName: projectName ?? this.projectName,
      outputPath: outputPath ?? this.outputPath,
      includeLogin: includeLogin ?? this.includeLogin,
      includeSignup: includeSignup ?? this.includeSignup,
      includeEmailVerification:
          includeEmailVerification ?? this.includeEmailVerification,
      includePhoneVerification:
          includePhoneVerification ?? this.includePhoneVerification,
      includeForgotPassword:
          includeForgotPassword ?? this.includeForgotPassword,
      includeOtp: includeOtp ?? this.includeOtp,
      includeSplashScreen: includeSplashScreen ?? this.includeSplashScreen,
      includeWelcomeScreen: includeWelcomeScreen ?? this.includeWelcomeScreen,
      includeGetStartedScreen:
          includeGetStartedScreen ?? this.includeGetStartedScreen,
      includeSocialAuth: includeSocialAuth ?? this.includeSocialAuth,
      includeDeviceToken: includeDeviceToken ?? this.includeDeviceToken,
      runPostGenerationActions:
          runPostGenerationActions ?? this.runPostGenerationActions,
    );
  }
}

class AuthFlowGenerator {
  final AuthFlowConfig config;
  late final AuthTemplates templates;
  late final ProjectConfig projectConfig;

  AuthFlowGenerator(this.config);

  Future<void> generate() async {
    projectConfig = await ProjectConfigReader.readOrDefault(
      projectName: config.projectName,
      projectPath: config.outputPath,
    );
    templates = AuthTemplates(projectConfig);

    Logger.step('Generating basic auth feature structure...');
    await _generateBasicAuthFeature();

    Logger.step('Creating additional auth-specific directories...');
    await _createAuthSpecificDirectories();

    Logger.step('Generating custom auth models...');
    await _generateAuthModels();

    Logger.step('Generating auth DTOs...');
    await _generateAuthDtos();

    Logger.step('Replacing with custom auth repository and service...');
    await _generateRepositoryLayer();

    Logger.step('Generating custom auth use cases...');
    await _generateUseCases();

    Logger.step('Replacing with custom auth BLoC...');
    await _generateAuthBloc();
    await _updateSharedBlocProvider();

    if (config.includeSplashScreen ||
        config.includeWelcomeScreen ||
        config.includeGetStartedScreen) {
      Logger.step('Generating onboarding screens...');
      await _generateOnboardingScreens();
    }

    if (config.includeLogin || config.includeSignup) {
      Logger.step('Generating auth screens...');
      await _generateAuthScreens();

      Logger.step('Generating auth controllers...');
      await _generateAuthControllers();
    }

    Logger.step('Generating index files...');
    await _generateIndexFiles();

    Logger.step('Updating router with auth routes...');
    await _updateRouterWithAuthRoutes();
    await _updateAppRoutes();

    Logger.verbose('AuthFlowGenerator: Running build_runner (final step)');
    await CommandUtils.runCommand(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
      workingDirectory: projectConfig.projectPath,
    );

    if (config.runPostGenerationActions) {
      Logger.verbose('AuthFlowGenerator: Running dart fix --apply');
      await CommandUtils.runCommand(
        'dart',
        ['fix', '--apply'],
        workingDirectory: projectConfig.projectPath,
      );
    }

    Logger.verbose('Auth flow generation completed');
  }

  /// Generate basic auth feature using the standard FeatureGenerator
  Future<void> _generateBasicAuthFeature() async {
    final authFeaturePath = path.join('lib', 'features', 'auth');

    final featureConfig = FeatureConfig(
      featureName: 'auth',
      outputPath: authFeaturePath,
      includeBloc: false,
      includeRepository: false,
      includeUseCases: false,
      includeModels: false,
      projectConfig: projectConfig,
    );

    final featureGenerator = FeatureGenerator(featureConfig);
    await featureGenerator.generate();

    Logger.verbose('Basic auth feature structure created');
  }

  /// Create auth-specific directories not covered by FeatureGenerator
  Future<void> _createAuthSpecificDirectories() async {
    final dirs = [
      path.join('lib', 'features', 'auth', 'data', 'enums'),
      path.join(
          'lib', 'features', 'auth', 'presentation', 'controllers', 'blocs'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers',
          'blocs', 'auth_bloc'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens', 'login'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens', 'signup'),
      path.join(
          'lib', 'features', 'auth', 'presentation', 'screens', 'onboarding'),
      path.join('lib', 'features', 'auth', 'presentation', 'helpers'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose('Created auth-specific directory: $dir');
    }
  }

  Future<void> _generateAuthModels() async {
    final files = {
      'lib/features/auth/data/models/auth_history_model.dart':
          templates.authHistoryModel,
      'lib/features/auth/data/models/user_model.dart': templates.userModel,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateAuthDtos() async {
    await Directory(
            path.join('lib', 'features', 'auth', 'data', 'remote', 'dto'))
        .create(recursive: true);

    final files = <String, String>{
      'lib/features/auth/data/remote/dto/auth_dtos.dart':
          templates.authDtosIndex,
    };

    if (config.includeLogin) {
      files['lib/features/auth/data/remote/dto/login_dto.dart'] =
          templates.loginDto;
    }
    if (config.includeSignup) {
      files['lib/features/auth/data/remote/dto/sign_up_dto.dart'] =
          templates.signUpDto;
    }

    if (config.includeOtp) {
      files['lib/features/auth/data/remote/dto/verify_dto.dart'] =
          templates.verifyDto;
      files['lib/features/auth/data/remote/dto/check_user_dto.dart'] =
          templates.checkUserDto;
      files['lib/features/auth/data/remote/dto/request_otp_dto.dart'] =
          templates.requestOtpDto;
    }

    if (config.includeForgotPassword) {
      files['lib/features/auth/data/remote/dto/reset_password_dto.dart'] =
          templates.resetPasswordDto;
    }

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateRepositoryLayer() async {
    final files = {
      'lib/features/auth/data/remote/auth_repository.dart':
          templates.authRepository,
      'lib/features/auth/data/remote/auth_service.dart': templates.authService,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateUseCases() async {
    final filePath = path.join(
        'lib', 'features', 'auth', 'data', 'domain', 'auth_use_cases.dart');
    await FileUtils.writeFile(filePath, templates.authUseCases);
    Logger.verbose('Generated: $filePath');
  }

  Future<void> _generateAuthBloc() async {
    final files = {
      'lib/features/auth/presentation/controllers/blocs/auth_bloc/auth_bloc.dart':
          templates.authBloc,
      'lib/features/auth/presentation/controllers/auth_bloc_provider.dart':
          templates.authBlocProvider,
      'lib/features/auth/presentation/controllers/blocs/auth_bloc/auth_event.dart':
          templates.authBlocEvents,
      'lib/features/auth/presentation/controllers/blocs/auth_bloc/auth_state.dart':
          templates.authBlocStates,
      'lib/features/auth/presentation/controllers/cubits/email_cubit/email_cubit.dart':
          templates.emailCubit,
      'lib/features/auth/presentation/controllers/cubits/user_cubit/user_cubit.dart':
          templates.userCubit,
      'lib/features/auth/presentation/controllers/cubits/auth_history_cubit/auth_history_cubit.dart':
          templates.authHistoryCubit,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateAuthScreens() async {
    final files = <String, String>{};

    if (config.includeLogin) {
      files['lib/features/auth/presentation/screens/login/login_screen.dart'] =
          templates.loginScreen;
    }

    if (config.includeSignup) {
      files['lib/features/auth/presentation/screens/signup/signup_screen.dart'] =
          templates.signupScreen;
    }

    if (config.includeOtp) {
      files['lib/features/auth/presentation/screens/otp/verify_otp_screen.dart'] =
          templates.verifyOtpScreen;
      files['lib/features/auth/presentation/widgets/resend_code_display.dart'] =
          templates.resendCodeDisplay;
      files['lib/features/auth/presentation/widgets/resend_code_text.dart'] =
          templates.resendCodeText;
    }

    if (config.includeForgotPassword) {
      files['lib/features/auth/presentation/screens/password_recovery/forgot_password_screen.dart'] =
          templates.forgotPasswordScreen;
      files['lib/features/auth/presentation/screens/password_recovery/forgot_password_verify_screen.dart'] =
          templates.forgotPwdVerifyScreen;
      files['lib/features/auth/presentation/screens/password_recovery/reset_password_screen.dart'] =
          templates.resetPasswordScreen;
    }

    if (files.isNotEmpty) {
      files['lib/features/auth/presentation/screens/auth_screen_index.dart'] =
          templates.authScreensIndex;
    }

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateAuthControllers() async {
    final files = <String, String>{};

    if (config.includeLogin) {
      files['lib/features/auth/presentation/helpers/auth_helper.dart'] =
          templates.authHelper;
      files['lib/features/auth/presentation/helpers/login_controller.dart'] =
          templates.loginController;
    }

    if (config.includeSignup) {
      files['lib/features/auth/presentation/helpers/signup_controller.dart'] =
          templates.signupController;
    }

    if (config.includeGetStartedScreen) {
      files['lib/features/auth/presentation/helpers/email_controller.dart'] =
          templates.emailController;
    }

    if (config.includeOtp) {
      files['lib/features/auth/presentation/helpers/verify_otp_controller.dart'] =
          templates.verifyOtpController;
    }

    if (config.includeForgotPassword) {
      files['lib/features/auth/presentation/helpers/forgot_password_controller.dart'] =
          templates.forgotPasswordController;
      files['lib/features/auth/presentation/helpers/reset_password_controller.dart'] =
          templates.resetPasswordController;
    }

    if (files.isNotEmpty) {
      files['lib/features/auth/presentation/helpers/auth_helper_index.dart'] =
          templates.authHelpersIndex;
    }

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateOnboardingScreens() async {
    final files = <String, String>{};

    if (config.includeSplashScreen) {
      files['lib/features/auth/presentation/screens/onboarding/splash_screen.dart'] =
          templates.splashScreen;
    }

    if (config.includeWelcomeScreen) {
      files['lib/features/auth/presentation/screens/onboarding/welcome_screen.dart'] =
          templates.welcomeScreen;
    }

    if (config.includeGetStartedScreen) {
      files['lib/features/auth/presentation/screens/onboarding/get_started_screen.dart'] =
          templates.getStartedScreen;
    }

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateIndexFiles() async {
    final files = {
      'lib/features/auth/auth_index.dart': templates.authIndex,
      'lib/features/auth/data/auth_data_index.dart': templates.authDataIndex,
      'lib/features/auth/presentation/auth_presentation_index.dart':
          templates.authPresentationIndex,
      'lib/features/auth/presentation/controllers/auth_controller_index.dart':
          templates.authControllerIndex,
    };

    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _updateSharedBlocProvider() async {
    final sharedPath = path.join(
      config.outputPath,
      'lib/features/shared/presentation/controllers/bloc_provider.dart',
    );

    final file = File(sharedPath);
    if (!await file.exists()) {
      Logger.verbose('Shared bloc_provider.dart not found, skipping update');
      return;
    }

    var content = await file.readAsString();

    final importLine =
        "import 'package:${config.projectName}/features/auth/presentation/controllers/auth_bloc_provider.dart';";

    if (content.contains(importLine)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has import for auth');
      return;
    }

    content = content.replaceFirst(
      "import 'package:flutter_bloc/flutter_bloc.dart';",
      "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
    );

    const spreadEntry = '  ...authBlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose(
          'Shared bloc_provider.dart already has entry for auth');
      await FileUtils.writeFile(sharedPath, content);
      return;
    }

    content = content.replaceFirst(
      '  // Add your feature BLoC providers here',
      '$spreadEntry\n  // Add your feature BLoC providers here',
    );

    await FileUtils.writeFile(sharedPath, content);
    Logger.verbose(
        'Updated shared bloc_provider.dart with auth provider');
  }

  Future<void> _updateRouterWithAuthRoutes() async {
    final routerPath = path.join(
      config.outputPath,
      'lib/navigation/router.dart',
    );

    final file = File(routerPath);
    if (!await file.exists()) {
      Logger.verbose('router.dart not found, skipping update');
      return;
    }

    var content = await file.readAsString();

    final authImport =
        "import 'package:${projectConfig.packageName}/features/auth/auth_index.dart';";
    if (!content.contains(authImport)) {
      content = content.replaceFirst(
        "import 'package:${projectConfig.packageName}/core/core.dart';",
        "import 'package:${projectConfig.packageName}/core/core.dart';\n$authImport",
      );
    }

    final routeEntries = StringBuffer();
    void addRoute(String path, String name, String widget) {
      routeEntries.writeln('    GoRoute(');
      routeEntries.writeln("      path: '$path',");
      routeEntries.writeln("      name: '$name',");
      routeEntries.writeln('      builder: (context, state) => const $widget(),');
      routeEntries.writeln('    ),');
    }

    addRoute('/', 'splash', 'SplashScreen');
    if (config.includeWelcomeScreen) {
      addRoute('/welcome', 'welcome', 'WelcomeScreen');
    }
    if (config.includeGetStartedScreen) {
      addRoute('/get-started', 'getStarted', 'GetStartedScreen');
    }
    if (config.includeLogin) {
      addRoute('/login', 'login', 'LoginScreen');
    }
    if (config.includeSignup) {
      addRoute('/signup', 'signup', 'SignupScreen');
    }
    if (config.includeOtp) {
      addRoute('/verify-otp', 'verifyOtp', 'VerifyOtpScreen');
    }
    if (config.includeForgotPassword) {
      addRoute('/forgot-password', 'forgotPassword', 'ForgotPasswordScreen');
      addRoute('/forgot-password-verify', 'forgotPasswordVerify',
          'ForgotPasswordVerifyScreen');
      addRoute('/reset-password', 'resetPassword', 'ResetPasswordScreen');
    }

    final routeBlock = '  routes: [\n${routeEntries.toString()}  ],';

    content = content.replaceFirstMapped(
      RegExp(r'  routes: \[[\s\S]*?\],'),
      (_) => routeBlock,
    );

    await FileUtils.writeFile(routerPath, content);
    Logger.verbose('Updated router.dart with auth routes');
  }

  Future<void> _updateAppRoutes() async {
    final routesPath = path.join(
      config.outputPath,
      'lib/navigation/routes.dart',
    );

    final file = File(routesPath);
    if (!await file.exists()) {
      Logger.verbose('routes.dart not found, skipping update');
      return;
    }

    var content = await file.readAsString();

    final routeConstants = StringBuffer();
    void addConstant(String name) {
      routeConstants.writeln("  static const $name = '$name';");
    }

    addConstant('splash');
    if (config.includeWelcomeScreen) addConstant('welcome');
    if (config.includeGetStartedScreen) addConstant('getStarted');
    if (config.includeLogin) addConstant('login');
    if (config.includeSignup) addConstant('signup');
    if (config.includeOtp) addConstant('verifyOtp');
    if (config.includeForgotPassword) {
      addConstant('forgotPassword');
      addConstant('forgotPasswordVerify');
      addConstant('resetPassword');
    }

    content = content.replaceFirstMapped(
      RegExp(r'class AppRoutes \{[\s\S]*?\}'),
      (_) => 'class AppRoutes {\n${routeConstants.toString()}}',
    );

    await FileUtils.writeFile(routesPath, content);
    Logger.verbose('Updated routes.dart with auth route constants');
  }

  /// Interactive method to collect user preferences
  static Future<AuthFlowConfig> createInteractiveConfig(
      String projectPath) async {
    Logger.header('Auth Flow Generator');
    Logger.info('Let\'s set up authentication for your Flutter project!\n');

    // Try to read project config to get the actual project name
    final projectConfig = await ProjectConfigReader.readFromCurrentDirectory();
    final projectName =
        projectConfig?.projectName ?? path.basename(projectPath);
    Logger.info('Project: $projectName');
    Logger.info('Location: $projectPath\n');

    // Ask about onboarding screens
    Logger.info('Onboarding Screens:');
    final includeSplashScreen =
        _askYesNo('Include Splash Screen?', defaultValue: true);
    final includeWelcomeScreen =
        _askYesNo('Include Welcome Screen?', defaultValue: true);
    final includeGetStartedScreen = _askYesNo(
        'Include Get Started Screen (email entry)?',
        defaultValue: true);

    // Ask about core auth features
    Logger.info('\nCore Authentication:');
    final includeLogin =
        _askYesNo('Include Login functionality?', defaultValue: true);
    final includeSignup =
        _askYesNo('Include Signup functionality?', defaultValue: true);

    // Ask about additional features
    Logger.info('\nAdditional Authentication Features:');
    final includeForgotPassword =
        _askYesNo('Include Forgot Password?', defaultValue: false);
    final includeOtp = _askYesNo(
        'Include OTP (One-Time Password) functionality?',
        defaultValue: false);

    // Ask about advanced features
    Logger.info('\nAdvanced Features:');
    final includeSocialAuth = _askYesNo(
        'Include Social Authentication placeholders?',
        defaultValue: false);
    final includeDeviceToken = _askYesNo(
        'Include Device Token support (for push notifications)?',
        defaultValue: false);

    return AuthFlowConfig(
      projectName: projectName,
      outputPath: projectPath,
      includeLogin: includeLogin,
      includeSignup: includeSignup,
      includeForgotPassword: includeForgotPassword,
      includeOtp: includeOtp,
      includeSplashScreen: includeSplashScreen,
      includeWelcomeScreen: includeWelcomeScreen,
      includeGetStartedScreen: includeGetStartedScreen,
      includeSocialAuth: includeSocialAuth,
      includeDeviceToken: includeDeviceToken,
    );
  }

  static bool _askYesNo(String question, {bool defaultValue = false}) {
    final defaultText = defaultValue ? 'Y/n' : 'y/N';
    stdout.write('$question ($defaultText): ');
    final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';

    if (input.isEmpty) return defaultValue;
    return input == 'y' || input == 'yes';
  }
}
