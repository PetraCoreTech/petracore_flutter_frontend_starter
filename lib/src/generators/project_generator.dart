import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';

import '../templates/project_templates.dart';
import '../utils/file_utils.dart';
import '../utils/logger.dart';

class ProjectConfig {
  final String projectName;
  final String organization;
  final String description;

  final String projectPath;

  ProjectConfig({
    required this.projectName,
    required this.organization,
    required this.description,
    required this.projectPath,
  });

  String get className => ReCase(projectName).pascalCase;
  String get packageName => projectName.toLowerCase().replaceAll('-', '_');
}

class ProjectGenerator {
  final ProjectConfig config;
  final ProjectTemplates templates;

  ProjectGenerator(this.config) : templates = ProjectTemplates(config);

  Future<void> generate() async {
    Logger.step('Creating project directory...');
    await _createDirectoryStructure();

    Logger.step('Generating Flutter project...');
    await _generateFlutterProject();

    Logger.step('Setting up project configuration...');
    await _generateProjectFiles();

    Logger.step('Setting up core architecture...');
    await _generateCoreFiles();

    Logger.step('Setting up navigation...');
    await _generateNavigationFiles();

    Logger.step('Setting up app structure...');
    await _generateAppFiles();

    Logger.step('Creating initial feature example...');
    await _generateSampleFeature();

    Logger.verbose('Project generation completed');
  }

  Future<void> _createDirectoryStructure() async {
    final dirs = [
      config.projectPath,
      path.join(config.projectPath, 'lib'),
      path.join(config.projectPath, 'lib', 'app'),
      path.join(config.projectPath, 'lib', 'app', 'app'),
      path.join(config.projectPath, 'lib', 'app', 'app', 'constants'),
      path.join(config.projectPath, 'lib', 'app', 'app', 'view'),
      path.join(config.projectPath, 'lib', 'app', 'theme'),
      path.join(config.projectPath, 'lib', 'app', 'theme', 'design_tokens'),
      path.join(config.projectPath, 'lib', 'app', 'theme', 'themes'),
      path.join(config.projectPath, 'lib', 'core'),
      path.join(config.projectPath, 'lib', 'core', 'components'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'buttons'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'frames'),
      path.join(
          config.projectPath, 'lib', 'core', 'components', 'input_fields'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'scaffolds'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'states'),
      path.join(config.projectPath, 'lib', 'core', 'data'),
      path.join(config.projectPath, 'lib', 'core', 'data', 'services'),
      path.join(
          config.projectPath, 'lib', 'core', 'data', 'services', 'network'),
      path.join(config.projectPath, 'lib', 'core', 'data', 'data_sources'),
      path.join(config.projectPath, 'lib', 'core', 'data', 'models'),
      path.join(config.projectPath, 'lib', 'core', 'utils'),
      path.join(config.projectPath, 'lib', 'core', 'utils', 'extensions'),
      path.join(config.projectPath, 'lib', 'core', 'utils', 'validation'),
      path.join(config.projectPath, 'lib', 'features'),
      path.join(config.projectPath, 'lib', 'features', 'shared'),
      path.join(
          config.projectPath, 'lib', 'features', 'shared', 'presentation'),
      path.join(config.projectPath, 'lib', 'features', 'shared', 'presentation',
          'controllers'),
      path.join(config.projectPath, 'lib', 'navigation'),
      path.join(config.projectPath, 'lib', 'navigation', 'routes'),
      path.join(config.projectPath, 'assets'),
      path.join(config.projectPath, 'assets', 'images'),
      path.join(config.projectPath, 'assets', 'svg'),
      path.join(config.projectPath, 'assets', 'lottie'),
      path.join(config.projectPath, 'fonts'),
    ];

    for (final dir in dirs) {
      await Directory(dir).create(recursive: true);
      Logger.verbose(
          'Created directory: ${path.relative(dir, from: config.projectPath)}');
    }
  }

  Future<void> _generateFlutterProject() async {
    await FileUtils.writeFile(
      path.join(config.projectPath, 'pubspec.yaml'),
      templates.pubspecYaml,
    );
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
      '.env': templates.envFile,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateCoreFiles() async {
    final files = {
      'lib/core/core.dart': templates.coreBarrel,
      'lib/core/components/components_index.dart': templates.componentsIndex,
      'lib/core/data/data_index.dart': templates.dataIndex,
      'lib/core/data/domain/use_case.dart': templates.domainUseCase,
      'lib/core/utils/utils_index.dart': templates.utilsIndex,
      'lib/core/utils/extensions/string_extensions.dart':
          templates.stringExtensions,
      'lib/core/utils/extensions/context_extensions.dart':
          templates.contextExtensions,
      'lib/core/utils/env_config.dart': templates.envConfig,
      
      // Validation utilities
      'lib/core/utils/validation/validation_index.dart': templates.validationIndex,
      'lib/core/utils/validation/input_field_validator.dart': templates.inputFieldValidator,
      'lib/core/utils/validation/string_extensions.dart': templates.utilsStringExtensions,
      
      // Network layer files
      'lib/core/data/services/network/network_index.dart': templates.networkIndex,
      'lib/core/data/services/network/network_service.dart': templates.networkService,
      'lib/core/data/services/network/api_interceptor.dart': templates.apiInterceptor,
      'lib/core/data/services/network/interceptor_strings.dart': templates.interceptorStrings,
      'lib/core/data/services/network/request_method.dart': templates.requestMethod,
      'lib/core/data/data_sources/auth_data_source.dart': templates.authDataSource,
      'lib/core/data/models/error_response.dart': templates.errorResponse,
      'lib/core/data/models/success_response.dart': templates.successResponse,
      
      // Component files with mixtheme integration
      'lib/core/components/buttons/app_button.dart': templates.appButton,
      'lib/core/components/buttons/app_button_style.dart': templates.appButtonStyle,
      'lib/core/components/buttons/app_button_type.dart': templates.appButtonType,
      'lib/core/components/input_fields/base_text_field.dart':
          templates.baseTextField,
      'lib/core/components/scaffolds/base_scaffold.dart':
          templates.baseScaffold,
      'lib/core/components/states/loading_indicator.dart':
          templates.loadingIndicator,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateNavigationFiles() async {
    final files = {
      'lib/navigation/router.dart': templates.router,
      'lib/navigation/routes.dart': templates.routes,
      'lib/navigation/navigation_index.dart': templates.navigationIndex,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateAppFiles() async {
    final files = {
      'lib/main.dart': templates.mainDart,
      'lib/bootstrap.dart': templates.bootstrap,
      'lib/app/app.dart': templates.appBarrel,
      'lib/app/app/view/app.dart': templates.appView,
      'lib/app/app/constants/app_constants.dart': templates.appConstants,
      
      // Theme system files
      'lib/app/theme/theme.dart': templates.themeBarrel,
      'lib/app/theme/color_values.dart': templates.colorValues,
      'lib/app/theme/design_tokens/theme_token.dart': templates.themeToken,
      'lib/app/theme/design_tokens/theme_color_token.dart': templates.themeColorToken,
      'lib/app/theme/design_tokens/theme_text_style_token.dart': templates.themeTextStyleToken,
      'lib/app/theme/design_tokens/theme_radius_token.dart': templates.themeRadiusToken,
      'lib/app/theme/themes/base_theme.dart': templates.baseTheme,
      'lib/app/theme/themes/light_theme.dart': templates.lightTheme,
      'lib/app/theme/themes/dark_theme.dart': templates.darkTheme,
      
      'lib/features/shared/presentation/controllers/bloc_provider.dart':
          templates.blocProvider,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }

  Future<void> _generateSampleFeature() async {
    // Create a simple 'home' feature as an example
    final featureFiles = {
      'lib/features/home/home_index.dart': templates.sampleFeatureIndex,
      'lib/features/home/presentation/screens/home_screen.dart':
          templates.sampleHomeScreen,
    };

    for (final entry in featureFiles.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }
}
