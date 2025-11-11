import 'dart:io';

import 'package:path/path.dart' as path;
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
    Logger.step('Checking Flutter installation...');
    await _checkFlutterInstallation();

    Logger.step('Creating Flutter project...');
    await _generateFlutterProject();

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

    Logger.verbose('Project generation completed');
  }

  Future<void> _createAdditionalDirectories() async {
    final dirs = [
      /// App config
      path.join(config.projectPath, 'lib', 'app'),
      path.join(config.projectPath, 'lib', 'app', 'constants'),
      path.join(config.projectPath, 'lib', 'app', 'view'),
      path.join(config.projectPath, 'lib', 'app', 'string_values'),
      path.join(config.projectPath, 'lib', 'app', 'theme'),
      path.join(config.projectPath, 'lib', 'app', 'theme', 'design_tokens'),
      path.join(config.projectPath, 'lib', 'app', 'theme', 'themes'),

      /// Core
      path.join(config.projectPath, 'lib', 'core'),

      /// Components
      path.join(config.projectPath, 'lib', 'core', 'components'),

      /// Components/AppBars
      path.join(config.projectPath, 'lib', 'core', 'components', 'app_bars'),

      /// Components/Builders
      path.join(config.projectPath, 'lib', 'core', 'components', 'builders'),

      /// Components/Buttons
      path.join(config.projectPath, 'lib', 'core', 'components', 'buttons'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'buttons',
          'app_button'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'buttons',
          'app_outline_button'),
      path.join(config.projectPath, 'lib', 'core', 'components', 'buttons',
          'app_text_button'),

      /// Components/Custom
      path.join(config.projectPath, 'lib', 'core', 'components', 'custom'),

      /// Components/Dialog
      path.join(config.projectPath, 'lib', 'core', 'components', 'dialog'),

      /// Components/Frames
      path.join(config.projectPath, 'lib', 'core', 'components', 'frames'),

      /// Components/Helpers
      path.join(config.projectPath, 'lib', 'core', 'components', 'helpers'),

      /// Components/InputFields
      path.join(
          config.projectPath, 'lib', 'core', 'components', 'input_fields'),

      /// Components/Scaffolds
      path.join(config.projectPath, 'lib', 'core', 'components', 'scaffolds'),

      /// Components/States
      path.join(config.projectPath, 'lib', 'core', 'components', 'states'),

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

      /// Core/Components
      'lib/core/components/components_index.dart': templates.componentsIndex,

      /// Core/Components/AppBar
      'lib/core/components/app_bars/app_bar_v1.dart': templates.appBarV1,
      'lib/core/components/app_bars/persistent_header_v1.dart':
          templates.persistentHeaderV1,
      'lib/core/components/app_bars/tab_bar_v1.dart': templates.tabBarV1,

      /// Core/Components/Buttons
      'lib/core/components/buttons/app_button/app_button.dart':
          templates.appButton,
      'lib/core/components/buttons/app_button/app_button_style.dart':
          templates.appButtonStyle,
      'lib/core/components/buttons/app_button/app_button_type.dart':
          templates.appButtonType,
      'lib/core/components/buttons/app_outline_button/app_outline_button.dart':
          templates.appOutlineButton,
      'lib/core/components/buttons/app_outline_button/app_outline_button_style.dart':
          templates.appOutlineButtonStyle,
      'lib/core/components/buttons/app_outline_button/app_outline_button_type.dart':
          templates.appOutlineButtonType,
      'lib/core/components/buttons/app_text_button/app_text_button.dart':
          templates.appTextButton,
      'lib/core/components/buttons/app_text_button/app_text_button_style.dart':
          templates.appTextButtonStyle,
      'lib/core/components/buttons/app_text_button/app_text_button_type.dart':
          templates.appTextButtonType,

      /// Core/Components/Custom
      'lib/core/components/custom/custom_icon.dart': templates.customIcon,
      'lib/core/components/custom/divider_v1.dart': templates.dividerV1,
      'lib/core/components/custom/dot.dart': templates.dot,
      'lib/core/components/custom/expansion_tile_v1.dart':
          templates.expansionTileV1,
      'lib/core/components/custom/hyper_link_text.dart':
          templates.hyperLinkText,
      'lib/core/components/custom/initials_display.dart':
          templates.initialsDisplay,
      'lib/core/components/custom/list_tile_v1.dart': templates.listTileV1,
      'lib/core/components/custom/password_strength_checker.dart':
          templates.passwordStrengthChecker,

      /// Core/Components/Dialog
      'lib/core/components/dialog/action_dialog.dart': templates.actionDialog,
      'lib/core/components/dialog/bottom_sheet_select_content.dart':
          templates.bottomSheetSelectContent,
      'lib/core/components/dialog/toast_v1.dart': templates.toastV1,

      /// Core/Components/Frames
      'lib/core/components/frames/icon_frame.dart': templates.iconFrame,
      'lib/core/components/frames/list_frame.dart': templates.listFrame,
      'lib/core/components/frames/profile_frame.dart': templates.profileFrame,
      'lib/core/components/frames/screen_frame.dart': templates.screenFrame,

      /// Core/Components/Helpers
      'lib/core/components/helpers/date_time_helper.dart':
          templates.dateTimeHelper,
      'lib/core/components/helpers/dialog_helper.dart': templates.dialogHelper,
      'lib/core/components/helpers/interaction_helper.dart':
          templates.interactionHelper,
      'lib/core/components/helpers/sliver_helper.dart': templates.sliverHelper,
      'lib/core/components/helpers/snackbar_helper.dart':
          templates.snackBarHelper,
      'lib/core/components/helpers/toast_helper.dart': templates.toastHelper,

      /// Core/Components/InputFields
      'lib/core/components/input_fields/base_text_field.dart':
          templates.baseTextField,
      'lib/core/components/input_fields/input_field.dart': templates.inputField,
      'lib/core/components/input_fields/input_item.dart': templates.inputItem,
      'lib/core/components/input_fields/password_field.dart':
          templates.passwordField,
      'lib/core/components/input_fields/phone_field.dart': templates.phoneField,
      'lib/core/components/input_fields/search_feature_field.dart':
          templates.searchFeatureField,
      'lib/core/components/input_fields/search_input_field.dart':
          templates.searchInputField,

      /// Core/Components/Scaffold
      'lib/core/components/scaffolds/base_scaffold.dart':
          templates.baseScaffold,
      'lib/core/components/scaffolds/scaffold_v1.dart': templates.scaffoldV1,

      /// Core/Components/States
      'lib/core/components/states/info_display.dart': templates.infoDisplay,
      'lib/core/components/states/loading_indicator.dart':
          templates.loadingIndicator,
      'lib/core/components/states/loading_overlay_v1.dart':
          templates.loadingOverlayV1,
      'lib/core/components/states/loading_shimmer.dart':
          templates.loadingShimmer,
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
      'lib/navigation/helpers/func.dart': templates.func,
      'lib/navigation/helpers/navigation_extension.dart':
          templates.navigationExtension,
      'lib/navigation/models/route_model.dart': templates.routeModel,
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

      /// App
      'lib/app/app.dart': templates.appBarrel,

      /// App/View
      'lib/app/view/app.dart': templates.appView,

      /// App/Constants
      'lib/app/constants/app_constants.dart': templates.appConstants,

      /// App/StringValues
      'lib/app/constants/content_strings.dart': templates.contentStrings,

      /// Theme system files
      'lib/app/theme/theme.dart': templates.themeBarrel,
      'lib/app/theme/color_values.dart': templates.colorValues,
      'lib/app/theme/design_tokens/theme_token.dart': templates.themeToken,
      'lib/app/theme/design_tokens/theme_color_token.dart':
          templates.themeColorToken,
      'lib/app/theme/design_tokens/theme_text_style_token.dart':
          templates.themeTextStyleToken,
      'lib/app/theme/design_tokens/theme_radius_token.dart':
          templates.themeRadiusToken,
      'lib/app/theme/themes/base_theme.dart': templates.baseTheme,
      'lib/app/theme/themes/light_theme.dart': templates.lightTheme,
      'lib/app/theme/themes/dark_theme.dart': templates.darkTheme,

      'lib/features/shared/presentation/controllers/bloc_provider.dart':
          templates.blocProvider,
      'lib/features/shared/presentation/controllers/key_value.dart':
          templates.keyValue,
      'lib/features/shared/data/type_def.dart': templates.typeDef,
      'lib/features/shared/shared_index.dart': templates.sharedIndex,
    };

    for (final entry in files.entries) {
      final filePath = path.join(config.projectPath, entry.key);
      await Directory(path.dirname(filePath)).create(recursive: true);
      await FileUtils.writeFile(filePath, entry.value);
      Logger.verbose('Generated: ${entry.key}');
    }
  }
}
