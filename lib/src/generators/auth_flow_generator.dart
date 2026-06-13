import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

import '../templates/auth/auth_templates.dart';
import '../utils/auth_validation.dart';
import '../utils/generated_region_writer.dart';

/// Configuration for generating a complete authentication flow within a
/// PetraCore Flutter project, controlling which auth features, onboarding
/// screens, and additional options are included.
class AuthFlowConfig {
  /// The name of the project being generated into.
  final String projectName;

  /// The absolute path to the project root where auth files will be created.
  final String outputPath;

  /// Whether to include login functionality.
  final bool includeLogin;

  /// Whether to include signup functionality.
  final bool includeSignup;

  /// Whether to include email verification flow.
  final bool includeEmailVerification;

  /// Whether to include phone verification flow.
  final bool includePhoneVerification;

  /// Whether to include forgot password flow.
  final bool includeForgotPassword;

  /// Whether to include OTP (One-Time Password) functionality.
  final bool includeOtp;

  /// Whether to include a splash screen.
  final bool includeSplashScreen;

  /// Whether to include a welcome / onboarding screen.
  final bool includeWelcomeScreen;

  /// Whether to include social authentication placeholders.
  final bool includeSocialAuth;

  /// Whether to include device token support for push notifications.
  final bool includeDeviceToken;

  /// Whether to run post-generation actions (e.g. updating shared providers,
  /// router, and route constants).
  final bool runPostGenerationActions;

  /// Creates an [AuthFlowConfig].
  ///
  /// By default [includeLogin], [includeSignup], [includeForgotPassword],
  /// [includeOtp], [includeSplashScreen], [includeWelcomeScreen], and
  /// [includeDeviceToken] are `true`. [includeEmailVerification],
  /// [includePhoneVerification], and [includeSocialAuth] are `false`.
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
    this.includeDeviceToken = true,
    this.includeSocialAuth = false,
    this.runPostGenerationActions = true,
  });

  /// [projectName] converted to a simple PascalCase by splitting on `_`
  /// and capitalizing each word.
  String get className => projectName
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join();

  /// Creates a copy of this [AuthFlowConfig] with the given fields replaced.
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
      includeSocialAuth: includeSocialAuth ?? this.includeSocialAuth,
      includeDeviceToken: includeDeviceToken ?? this.includeDeviceToken,
      runPostGenerationActions:
          runPostGenerationActions ?? this.runPostGenerationActions,
    );
  }
}

/// Generates a complete authentication flow within a PetraCore Flutter
/// project, including models, DTOs, repository layer, use cases, BLoC/Cubit
/// state management, screens, controllers, onboarding screens, and router
/// wiring.
class AuthFlowGenerator {
  /// The configuration driving auth flow generation.
  final AuthFlowConfig config;

  /// The templates instance used to render auth source files.
  late final AuthTemplates templates;

  /// The resolved project config, initialized during [generate].
  late final ProjectConfig projectConfig;

  /// Creates an [AuthFlowGenerator] with the given [config].
  AuthFlowGenerator(this.config);

  /// Executes the full auth flow generation pipeline.
  ///
  /// Validates the config, creates directory structure, writes all auth
  /// source files (models, DTOs, repository, use cases, BLoC, screens,
  /// controllers, onboarding, index files), and updates the shared
  /// [BlocProvider], router, and route constants in the project.
  Future<void> generate() async {
    AuthValidation.validateConfig(config);
    Directory.current = config.outputPath;
    projectConfig = await ProjectConfigReader.readOrDefault(
      projectName: config.projectName,
      projectPath: config.outputPath,
    );
    templates = AuthTemplates(projectConfig);

    Logger.step('Creating auth feature structure...');
    await _createDirectories();

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

    if (config.includeSplashScreen || config.includeWelcomeScreen) {
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

    Logger.verbose('Auth flow generation completed.');
    Logger.info('Run `dart run build_runner build` to generate code.');
  }

  Future<void> _createDirectories() async {
    final dirs = [
      path.join('lib', 'features', 'auth'),
      path.join('lib', 'features', 'auth', 'data'),
      path.join('lib', 'features', 'auth', 'data', 'models'),
      path.join('lib', 'features', 'auth', 'data', 'remote'),
      path.join('lib', 'features', 'auth', 'data', 'remote', 'dto'),
      path.join('lib', 'features', 'auth', 'data', 'domain'),
      path.join('lib', 'features', 'auth', 'data', 'enums'),
      path.join('lib', 'features', 'auth', 'presentation'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers',
          'blocs'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers',
          'blocs', 'auth_bloc'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers', 'cubits'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers', 'cubits', 'email_cubit'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers', 'cubits', 'user_cubit'),
      path.join('lib', 'features', 'auth', 'presentation', 'controllers', 'cubits', 'auth_history_cubit'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens', 'login'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens', 'signup'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens',
          'onboarding'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens', 'otp'),
      path.join('lib', 'features', 'auth', 'presentation', 'screens',
          'password_recovery'),
      path.join('lib', 'features', 'auth', 'presentation', 'helpers'),
      path.join('lib', 'features', 'auth', 'presentation', 'widgets'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose('Created directory: $dir');
    }
  }

  Future<void> _generateAuthModels() async {
    final files = {
      'lib/features/auth/data/models/auth_history_model.dart':
          templates.authHistoryModel,
      'lib/features/auth/data/models/user_model.dart': templates.userModel,
    };

    final progress = Logger.fileProgress('Auth models');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
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

    final progress = Logger.fileProgress('Auth DTOs');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateRepositoryLayer() async {
    final files = {
      'lib/features/auth/data/remote/auth_repository.dart':
          templates.authRepository,
      'lib/features/auth/data/remote/auth_service.dart': templates.authService,
    };

    final progress = Logger.fileProgress('Auth repository');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateUseCases() async {
    final filePath = path.join(
        'lib', 'features', 'auth', 'data', 'domain', 'auth_use_cases.dart');
    final progress = Logger.fileProgress('Auth use cases');
    progress.start(1);
    await FileUtils.writeFile(filePath, templates.authUseCases);
    progress.tick();
    progress.done();
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

    final progress = Logger.fileProgress('Auth BLoC');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
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

    final progress = Logger.fileProgress('Auth screens');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
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

    if (config.includeOtp) {
      files['lib/features/auth/presentation/helpers/verify_otp_controller.dart'] =
          templates.verifyOtpController;
    }

    if (config.includeForgotPassword) {
      files['lib/features/auth/presentation/helpers/email_controller.dart'] =
          templates.emailController;
      files['lib/features/auth/presentation/helpers/forgot_password_controller.dart'] =
          templates.forgotPasswordController;
      files['lib/features/auth/presentation/helpers/reset_password_controller.dart'] =
          templates.resetPasswordController;
    }

    if (files.isNotEmpty) {
      files['lib/features/auth/presentation/helpers/auth_helper_index.dart'] =
          templates.authHelpersIndex;
    }

    final progress = Logger.fileProgress('Auth controllers');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateOnboardingScreens() async {
    final files = <String, String>{};

    if (config.includeSplashScreen) {
      files['lib/features/auth/presentation/screens/onboarding/splash_screen.dart'] =
          templates.splashScreen;
      files['lib/features/auth/presentation/widgets/animated_splash_logo.dart'] =
          templates.animatedSplashLogo;
    }

    if (config.includeWelcomeScreen) {
      files['lib/features/auth/presentation/screens/onboarding/welcome_screen.dart'] =
          templates.welcomeScreen;
    }

    final progress = Logger.fileProgress('Onboarding screens');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
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

    final progress = Logger.fileProgress('Index files');
    progress.start(files.length);
    for (final entry in files.entries) {
      await FileUtils.writeFile(entry.key, entry.value);
      progress.tick();
    }
    progress.done();
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

    final importLine =
        "import 'package:${projectConfig.packageName}/features/auth/presentation/controllers/auth_bloc_provider.dart';";

    var content = await file.readAsString();
    if (!content.contains(importLine)) {
      content = content.replaceFirst(
        "import 'package:flutter_bloc/flutter_bloc.dart';",
        "import 'package:flutter_bloc/flutter_bloc.dart';\n$importLine",
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    const spreadEntry = '  ...authBlocProvider,';

    if (content.contains(spreadEntry)) {
      Logger.verbose('Shared bloc_provider.dart already has entry for auth');
      return;
    }

    if (await GeneratedRegionWriter.regionExists(
          filePath: sharedPath,
          regionName: 'bloc_providers',
        )) {
      final existing = await _readRegionContent(
        sharedPath, 'bloc_providers',
      );
      await GeneratedRegionWriter.replaceRegion(
        filePath: sharedPath,
        regionName: 'bloc_providers',
        newContent: '$existing\n$spreadEntry',
      );
    } else {
      content = await file.readAsString();
      content = content.replaceFirst(
        '  // petracore:start:bloc_providers',
        '  // petracore:start:bloc_providers\n$spreadEntry',
      );
      await FileUtils.writeFile(sharedPath, content);
    }

    Logger.verbose('Updated shared bloc_provider.dart with auth provider');
  }

  Future<void> _updateRouterWithAuthRoutes() async {
    final projectRoot = config.outputPath;
    final routesDir = path.join(projectRoot, 'lib/navigation/routes');
    await Directory(routesDir).create(recursive: true);

    final authRoutesContent = StringBuffer();
    authRoutesContent.writeln(
        "import 'package:${projectConfig.packageName}/core/core.dart';");
    authRoutesContent.writeln(
        "import 'package:${projectConfig.packageName}/features/auth/auth_index.dart';");
    authRoutesContent.writeln();
    authRoutesContent.writeln('final authRoutes = <GoRoute>[');

    if (config.includeWelcomeScreen) {
      _buildWelcomeRoute(authRoutesContent);
    } else {
      _buildStandaloneAuthRoutes(authRoutesContent, indent: 0);
    }

    authRoutesContent.writeln('];');

    final authRoutesPath = path.join(routesDir, 'auth_routes.dart');
    await FileUtils.writeFile(authRoutesPath, authRoutesContent.toString());
    Logger.verbose('Created lib/navigation/routes/auth_routes.dart');

    final routerPath = path.join(projectRoot, 'lib/navigation/router.dart');
    final routerFile = File(routerPath);
    if (!await routerFile.exists()) {
      Logger.verbose('router.dart not found, skipping update');
      return;
    }

    var routerContent = await routerFile.readAsString();

    final authRoutesImport =
        "import 'package:${projectConfig.packageName}/navigation/routes/auth_routes.dart';";
    if (!routerContent.contains(authRoutesImport)) {
      routerContent = routerContent.replaceFirst(
        "import 'package:${projectConfig.packageName}/core/core.dart';",
        "import 'package:${projectConfig.packageName}/core/core.dart';\n$authRoutesImport",
      );
      await FileUtils.writeFile(routerPath, routerContent);
    }

    final spreadEntry = '    ...authRoutes,';
    if (!routerContent.contains(spreadEntry)) {
      if (await GeneratedRegionWriter.regionExists(
            filePath: routerPath,
            regionName: 'feature_routes',
          )) {
        final existing = await _readRegionContent(
          routerPath, 'feature_routes',
        );
        await GeneratedRegionWriter.replaceRegion(
          filePath: routerPath,
          regionName: 'feature_routes',
          newContent: '$existing\n$spreadEntry',
        );
      } else {
        routerContent = await File(routerPath).readAsString();
        routerContent = routerContent.replaceFirst(
          '    // petracore:start:feature_routes',
          '    // petracore:start:feature_routes\n$spreadEntry',
        );
        await FileUtils.writeFile(routerPath, routerContent);
      }
    }
    Logger.verbose('Updated router.dart with auth routes');
  }

  void _buildWelcomeRoute(StringBuffer buffer) {
    buffer.writeln('  GoRoute(');
    buffer.writeln('    path: AppRoutes.welcome.path,');
    buffer.writeln('    name: AppRoutes.welcome.name,');
    buffer.writeln(
        '    builder: (context, state) => const WelcomeScreen(),');

    final hasChildren = config.includeLogin ||
        config.includeSignup ||
        config.includeOtp;

    if (hasChildren) {
      buffer.writeln('    routes: [');
      _buildLoginRoute(buffer, indent: 6);
      _buildSignupRoute(buffer, indent: 6);
      _buildOtpRoute(buffer, indent: 6);
      buffer.writeln('    ],');
    }

    buffer.writeln('  ),');
  }

  void _buildStandaloneAuthRoutes(StringBuffer buffer, {int indent = 4}) {
    _buildLoginRoute(buffer, indent: indent);
    _buildSignupRoute(buffer, indent: indent);
    _buildOtpRoute(buffer, indent: indent);
  }

  void _buildLoginRoute(StringBuffer buffer, {int indent = 4}) {
    if (!config.includeLogin) return;
    final i = ' ' * indent;
    buffer.writeln('${i}GoRoute(');
    buffer.writeln('${i}  path: AppRoutes.login.path,');
    buffer.writeln('${i}  name: AppRoutes.login.name,');
    buffer.writeln('${i}  builder: (context, state) => const LoginScreen(),');

    if (config.includeForgotPassword) {
      buffer.writeln('${i}  routes: [');
      buffer.writeln('${i}    GoRoute(');
      buffer.writeln(
          '${i}      path: AppRoutes.forgotPassword.path,');
      buffer.writeln(
          '${i}      name: AppRoutes.forgotPassword.name,');
      buffer.writeln('${i}      builder: (context, state) => const ForgotPasswordScreen(),');
      buffer.writeln('${i}    ),');
      buffer.writeln('${i}    GoRoute(');
      buffer.writeln(
          '${i}      path: AppRoutes.forgotPasswordVerify.path,');
      buffer.writeln(
          '${i}      name: AppRoutes.forgotPasswordVerify.name,');
      buffer.writeln('${i}      builder: (context, state) => const ForgotPasswordVerifyScreen(),');
      buffer.writeln('${i}    ),');
      buffer.writeln('${i}    GoRoute(');
      buffer.writeln(
          '${i}      path: AppRoutes.resetPassword.path,');
      buffer.writeln(
          '${i}      name: AppRoutes.resetPassword.name,');
      buffer.writeln('${i}      builder: (context, state) => const ResetPasswordScreen(),');
      buffer.writeln('${i}    ),');
      buffer.writeln('${i}  ],');
    }

    buffer.writeln('${i}),');
  }

  void _buildSignupRoute(StringBuffer buffer, {int indent = 4}) {
    if (!config.includeSignup) return;
    final i = ' ' * indent;
    buffer.writeln('${i}GoRoute(');
    buffer.writeln('${i}  path: AppRoutes.signup.path,');
    buffer.writeln('${i}  name: AppRoutes.signup.name,');
    buffer.writeln('${i}  builder: (context, state) => const SignupScreen(),');
    buffer.writeln('${i}),');
  }

  void _buildOtpRoute(StringBuffer buffer, {int indent = 4}) {
    if (!config.includeOtp) return;
    final i = ' ' * indent;
    buffer.writeln('${i}GoRoute(');
    buffer.writeln('${i}  path: AppRoutes.verifyOtp.path,');
    buffer.writeln('${i}  name: AppRoutes.verifyOtp.name,');
    buffer.writeln('${i}  builder: (context, state) => const VerifyOtpScreen(),');
    buffer.writeln('${i}),');
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

    final buffer = StringBuffer();
    final existingConstants = <String>{};

    if (await GeneratedRegionWriter.regionExists(
          filePath: routesPath,
          regionName: 'route_constants',
        )) {
      final existing = await _readRegionContent(
        routesPath, 'route_constants',
      );
      for (final match in RegExp(r"static const (\w+) =")
          .allMatches(existing)) {
        existingConstants.add(match.group(1)!);
      }
    }

    void addConstant(String name, String pathStr) {
      if (existingConstants.contains(name)) return;
      if (buffer.isNotEmpty) buffer.writeln();
      buffer.write(
          "  static const $name = AppRoute(path: '$pathStr', name: '$name');");
      existingConstants.add(name);
    }

    if (config.includeSplashScreen) addConstant('splash', '/');
    if (config.includeWelcomeScreen) addConstant('welcome', '/welcome');
    if (config.includeLogin) addConstant('login', 'login');
    if (config.includeSignup) addConstant('signup', 'signup');
    if (config.includeOtp) addConstant('verifyOtp', 'verify-otp');
    if (config.includeForgotPassword) {
      addConstant('forgotPassword', 'forgot-password');
      addConstant('forgotPasswordVerify', 'forgot-password-verify');
      addConstant('resetPassword', 'reset-password');
    }

    final newConstants = buffer.toString();
    if (newConstants.isEmpty) {
      Logger.verbose('All auth route constants already exist, skipping');
      return;
    }

    if (await GeneratedRegionWriter.regionExists(
          filePath: routesPath,
          regionName: 'route_constants',
        )) {
      final existing = await _readRegionContent(
        routesPath, 'route_constants',
      );
      final merged = '$existing\n$newConstants'.trim();
      await GeneratedRegionWriter.replaceRegion(
        filePath: routesPath,
        regionName: 'route_constants',
        newContent: merged,
      );
    } else {
      var content = await file.readAsString();
      content = content.replaceFirst(
        '  // petracore:start:route_constants',
        '  // petracore:start:route_constants\n$newConstants',
      );
      await FileUtils.writeFile(routesPath, content);
    }

    Logger.verbose('Updated routes.dart with auth route constants');
  }

  Future<String> _readRegionContent(String filePath, String regionName) async {
    final file = File(filePath);
    final content = await file.readAsString();
    final startMarker = '// petracore:start:$regionName';
    final endMarker = '// petracore:end:$regionName';
    final startIndex = content.indexOf(startMarker) + startMarker.length;
    final endIndex = content.indexOf(endMarker);
    return content.substring(startIndex, endIndex).trim();
  }

  /// Interactive method to collect user preferences
  static Future<AuthFlowConfig> createInteractiveConfig(
      String projectPath) async {
    Logger.header('Auth Flow Generator');
    Logger.info('Let\'s set up authentication for your Flutter project!\n');

    // Try to read project config to get the actual project name
    final projectConfig =
        await ProjectConfigReader.readFromDirectory(projectPath);
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
