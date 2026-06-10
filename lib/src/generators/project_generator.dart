import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:petracore_flutter_frontend_starter/src/design_presets/design_preset.dart';
import 'package:petracore_flutter_frontend_starter/src/design_presets/design_preset_registry.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/pagination_index_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_bloc_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_event_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/presentation/controllers/pagination_bloc/pagination_state_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/presentation/widgets/paginated_list_builder_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/feature/pagination/presentation/widgets/paginated_list_view_template.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/main_app/main_app_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/project_templates.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/command_utils.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/file_utils.dart';
import 'package:petracore_flutter_frontend_starter/src/utils/logger.dart';
import 'package:recase/recase.dart';

class ProjectConfig {
  final String projectName;
  final String organization;
  final String description;
  final String projectPath;
  final DesignPresetId designPreset;

  ProjectConfig({
    required this.projectName,
    required this.organization,
    required this.description,
    required this.projectPath,
    this.designPreset = DesignPresetId.defaultPreset,
  });

  String get className => ReCase(projectName).pascalCase;
  String get packageName => projectName.toLowerCase().replaceAll('-', '_');

  DesignPreset get resolvedDesignPreset =>
      DesignPresetRegistry.resolve(designPreset);
}

class ProjectGenerator {
  final ProjectConfig config;
  final ProjectTemplates templates;

  ProjectGenerator(this.config) : templates = ProjectTemplates(config);

  Future<void> generate() async {
    Logger.step('Checking Flutter installation...');
    await _checkFlutterInstallation();

    Logger.step('Creating Flutter project...');
    await _generateFlutterProject();

    Logger.step('Configuring Android NDK version...');
    await _updateAndroidNdkVersion();

    Logger.step('Creating additional directory structure...');
    await _createAdditionalDirectories();

    Logger.step('Setting up project configuration...');
    await _generateProjectFiles();

    Logger.step('Setting up core architecture...');
    await _generateCoreFiles();

    Logger.step('Setting up navigation...');
    await _generateNavigationFiles();

    Logger.step('Setting up app structure...');
    await _generateAppFiles();

    Logger.step('Generating main_app feature...');
    await _generateMainApp();

    Logger.step('Generating pagination feature...');
    await _generatePaginationFeature();
  }

  Future<void> _generatePaginationFeature() async {
    final String projectName = config.projectName;
    final String featurePath = path.join(config.projectPath, 'lib', 'features', 'pagination');

    // Create directories
    final List<String> dirs = [
      featurePath,
      path.join(featurePath, 'presentation'),
      path.join(featurePath, 'presentation', 'controllers'),
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc'),
      path.join(featurePath, 'presentation', 'widgets'),
    ];

    for (final String dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose('Created directory: $dir');
    }

    // Generate pagination_index.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'pagination_index.dart'),
      paginationIndexTemplate(projectName),
    );
    Logger.verbose('Generated: pagination_index.dart');

    // Generate pagination_event.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_event.dart'),
      paginationEventTemplate(projectName),
    );
    Logger.verbose('Generated: pagination_event.dart');

    // Generate pagination_state.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_state.dart'),
      paginationStateTemplate(projectName),
    );
    Logger.verbose('Generated: pagination_state.dart');

    // Generate pagination_bloc.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'controllers', 'pagination_bloc', 'pagination_bloc.dart'),
      paginationBlocTemplate(projectName),
    );
    Logger.verbose('Generated: pagination_bloc.dart');

    // Generate paginated_list_view.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'widgets', 'paginated_list_view.dart'),
      paginatedListViewTemplate(projectName),
    );
    Logger.verbose('Generated: paginated_list_view.dart');

    // Generate paginated_list_builder.dart
    await FileUtils.writeFile(
      path.join(featurePath, 'presentation', 'widgets', 'paginated_list_builder.dart'),
      paginatedListBuilderTemplate(projectName),
    );
    Logger.verbose('Generated: paginated_list_builder.dart');
  }

  Future<void> _updateAndroidNdkVersion() async {
    final buildGradlePath = path.join(
      config.projectPath,
      'android',
      'app',
      'build.gradle.kts',
    );
    final buildGradleFile = File(buildGradlePath);

    if (!await buildGradleFile.exists()) {
      Logger.verbose('Android build.gradle.kts not found, skipping NDK config');
      return;
    }

    var content = await buildGradleFile.readAsString();
    final ndkRegex = RegExp(r'ndkVersion\s*=\s*\S+');

    if (ndkRegex.hasMatch(content)) {
      content = content.replaceAll(ndkRegex, 'ndkVersion = "27.0.12077973"');
    } else {
      final androidBlock = RegExp(r'android\s*\{');
      content = content.replaceFirst(
        androidBlock,
        'android {\n    ndkVersion = "27.0.12077973"',
      );
    }

    await buildGradleFile.writeAsString(content);
    Logger.verbose('Android NDK version set to 27.0.12077973');
  }

  Future<void> _createAdditionalDirectories() async {
    final dirs = [
      /// App config
      path.join(config.projectPath, 'lib', 'app'),
      path.join(config.projectPath, 'lib', 'app', 'constants'),

      path.join(config.projectPath, 'lib', 'app', 'string_values'),

      /// Core
      path.join(config.projectPath, 'lib', 'core'),

      /// Data
      path.join(config.projectPath, 'lib', 'core', 'data'),

      /// Data/Domain
      path.join(config.projectPath, 'lib', 'core', 'data', 'domain'),

      /// Data/Local
      path.join(config.projectPath, 'lib', 'core', 'data', 'local'),

      /// Data/Services
      path.join(config.projectPath, 'lib', 'core', 'data', 'services'),
      path.join(
          config.projectPath, 'lib', 'core', 'data', 'services', 'api_client'),

      /// Data/Models
      path.join(config.projectPath, 'lib', 'core', 'data', 'models'),

      /// Data/Enums
      path.join(config.projectPath, 'lib', 'core', 'data', 'enums'),

      /// Data/Utils
      path.join(config.projectPath, 'lib', 'core', 'data', 'utils'),

      /// Utils
      path.join(config.projectPath, 'lib', 'core', 'utils'),
      path.join(config.projectPath, 'lib', 'core', 'utils', 'extensions'),
      path.join(config.projectPath, 'lib', 'core', 'utils', 'validation'),

      /// Features
      path.join(config.projectPath, 'lib', 'features'),

      /// Features/MainApp
      path.join(config.projectPath, 'lib', 'features', 'main_app'),
      path.join(config.projectPath, 'lib', 'features', 'main_app',
          'presentation'),
      path.join(config.projectPath, 'lib', 'features', 'main_app',
          'presentation', 'controllers'),
      path.join(config.projectPath, 'lib', 'features', 'main_app',
          'presentation', 'screens'),

      /// Features/Shared
      path.join(config.projectPath, 'lib', 'features', 'shared'),
      path.join(
          config.projectPath, 'lib', 'features', 'shared', 'presentation'),
      path.join(config.projectPath, 'lib', 'features', 'shared', 'presentation',
          'controllers'),

      /// Navigation
      path.join(config.projectPath, 'lib', 'navigation'),

      /// Navigation/Routes
      path.join(config.projectPath, 'lib', 'navigation', 'routes'),

      /// Navigation/Helpers
      path.join(config.projectPath, 'lib', 'navigation', 'helpers'),

      /// Navigation/Models
      path.join(config.projectPath, 'lib', 'navigation', 'models'),

      /// Assets
      path.join(config.projectPath, 'assets'),
      path.join(config.projectPath, 'assets', 'images'),
      path.join(config.projectPath, 'assets', 'svg'),
      path.join(config.projectPath, 'assets', 'lottie'),

      /// Font
      path.join(config.projectPath, 'fonts'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose(
          'Created directory: ${path.relative(dir, from: config.projectPath)}');
    }
  }

  Future<void> _checkFlutterInstallation() async {
    final isFlutterAvailable = await CommandUtils.isCommandAvailable('flutter');
    if (!isFlutterAvailable) {
      Logger.error('Flutter CLI not found in PATH');
      Logger.info('Please install Flutter and ensure it\'s in your PATH');
      Logger.info(
          'Visit https://flutter.dev/docs/get-started/install for instructions');
      throw StateError('Flutter CLI not available');
    }
    Logger.verbose('Flutter CLI found');
  }

  Future<void> _generateFlutterProject() async {
    final projectDir = Directory(config.projectPath);

    if (!await projectDir.exists()) {
      await projectDir.create(recursive: true);
    }

    final parentDir = projectDir.parent.path;
    final projectName = path.basename(config.projectPath);

    Logger.verbose('Running flutter create in $parentDir');

    try {
      await CommandUtils.runFlutterCommand(
        [
          'create',
          '--org',
          config.organization,
          '--project-name',
          config.packageName,
          '--platforms',
          'android,ios,web,macos,windows,linux',
          projectName,
        ],
        workingDirectory: parentDir,
        showOutput: true,
      );

      Logger.success('Flutter project created successfully');

      await FileUtils.writeFile(
        path.join(config.projectPath, 'pubspec.yaml'),
        templates.pubspecYaml,
      );

      Logger.verbose('Updated pubspec.yaml with PetraCore dependencies');

      Logger.verbose('Running flutter pub get');

      await CommandUtils.runFlutterCommand(
        ['pub', 'get'],
        workingDirectory: config.projectPath,
        showOutput: true,
      );
    } catch (e) {
      Logger.error('Failed to create Flutter project: $e');
      throw StateError('Flutter create command failed: $e');
    }
  }

  Future<void> _generateProjectFiles() async {
    final files = {
      'analysis_options.yaml': templates.analysisOptions,
      '.gitignore': templates.gitignore,
      'README.md': templates.readme,
      'ENV_CONFIG.md': templates.dartDefineDocs,
      'devtools_options.yaml': templates.devtoolsOptions,
      '.vscode/settings.json': templates.vscodeSettings,
      '.vscode/launch.json': templates.vscodeLaunch,
      'env.json': templates.envJson,
      'petracore.config.json': templates.petracoreConfig,
    };

    final progress = Logger.fileProgress('Project config');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateCoreFiles() async {
    final files = {
      /// Core
      'lib/core/core.dart': templates.coreBarrel,

      /// Core/Data
      'lib/core/data/data_index.dart': templates.dataIndex,

      /// Core/Data/Domain
      'lib/core/data/domain/use_case.dart': templates.domainUseCase,

      /// Core/Data/Enums
      'lib/core/data/enums/request_method.dart': templates.requestMethod,

      /// Core/Data/Local
      'lib/core/data/local/local_auth_data.dart': templates.localAuthData,

      /// Core/Data/Models
      'lib/core/data/models/error_response.dart': templates.errorResponse,
      'lib/core/data/models/success_response.dart': templates.successResponse,
      'lib/core/data/models/base_model.dart': templates.baseModel,

      /// Core/Data/Services
      'lib/core/data/services/api_client/api_client_index.dart':
          templates.apiClientIndex,
      'lib/core/data/services/api_client/api_client.dart': templates.apiClient,
      'lib/core/data/services/api_client/api_interceptor.dart':
          templates.apiInterceptor,
      'lib/core/data/services/api_client/api_error.dart': templates.apiError,
      'lib/core/data/services/api_client/interceptor_strings.dart':
          templates.interceptorStrings,

      /// Core/Data/Utils
      'lib/core/utils/env_config.dart': templates.envConfig,

      /// Core/Utils
      'lib/core/utils/utils_index.dart': templates.utilsIndex,
      'lib/core/utils/extensions/bool_extension.dart': templates.boolExtension,
      'lib/core/utils/extensions/context_extensions.dart':
          templates.contextExtensions,
      'lib/core/utils/extensions/ctx_responsive_ext.dart':
          templates.ctxResponsiveExt,
      'lib/core/utils/extensions/date_time_extension.dart':
          templates.dateTimeExtension,
      'lib/core/utils/extensions/int_extension.dart': templates.intExtension,
      'lib/core/utils/extensions/list_extension.dart': templates.listExtension,
      'lib/core/utils/extensions/page_controller_ext.dart':
          templates.pageControllerExt,
      'lib/core/utils/extensions/string_extension.dart':
          templates.stringExtension,
      'lib/core/utils/validation/input_field_validator.dart':
          templates.inputFieldValidator,

    };

    final progress = Logger.fileProgress('Core files');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateNavigationFiles() async {
    final files = {
      'lib/navigation/router.dart': templates.router,
      'lib/navigation/routes.dart': templates.routes,
      'lib/navigation/navigation_index.dart': templates.navigationIndex,
      'lib/navigation/helpers/func.dart': templates.func,
      'lib/navigation/helpers/navigation_extension.dart':
          templates.navigationExtension,
      'lib/navigation/models/route_model.dart': templates.routeModel,
    };

    final progress = Logger.fileProgress('Navigation');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateAppFiles() async {
    final files = {
      'lib/main.dart': templates.mainDart,
      'lib/bootstrap.dart': templates.bootstrap,

      /// App
      'lib/app/app.dart': templates.appBarrel,

      /// App/Constants
      'lib/app/constants/app_constants.dart': templates.appConstants,

      /// App/StringValues
      'lib/app/constants/content_strings.dart': templates.contentStrings,

    };

    files.addAll({
      'lib/features/shared/presentation/controllers/bloc_provider.dart':
          templates.blocProvider,
      'lib/features/shared/presentation/controllers/key_value.dart':
          templates.keyValue,
      'lib/features/shared/data/type_def.dart': templates.typeDef,
      'lib/features/shared/shared_index.dart': templates.sharedIndex,
    });

    final progress = Logger.fileProgress('App structure');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }

  Future<void> _generateMainApp() async {
    final mainAppTemplates = MainAppTemplates(config);

    final files = {
      'lib/features/main_app/main_app_index.dart':
          mainAppTemplates.mainAppIndex,
      'lib/features/main_app/presentation/presentation.dart':
          mainAppTemplates.presentationBarrel,
      'lib/features/main_app/presentation/controllers/main_app_controller_index.dart':
          mainAppTemplates.controllerIndex,
      'lib/features/main_app/presentation/controllers/main_app_bloc_provider.dart':
          mainAppTemplates.blocProvider,
      'lib/features/main_app/presentation/screens/dashboard_screen.dart':
          mainAppTemplates.dashboardScreen,
      'lib/features/main_app/presentation/screens/app_entry_screen.dart':
          mainAppTemplates.appEntryScreen,
    };

    final progress = Logger.fileProgress('Main app feature');
    progress.start(files.length);
    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      progress.tick();
    }
    progress.done();
  }
}
