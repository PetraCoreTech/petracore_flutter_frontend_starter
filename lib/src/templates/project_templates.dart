import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/project/project_bloc_provider_template.dart';

import 'project/analysis_options_template.dart';
import 'project/app_barrel_template.dart';
import 'project/app_constants_template.dart';
import 'project/app_view_template.dart';
import 'project/base_theme_template.dart';
import 'project/bootstrap_template.dart';
import 'project/color_values_template.dart';
import 'project/components/app_button_style_template.dart';
// Component templates
import 'project/components/app_bar_v1_template.dart';
import 'project/components/app_button_template.dart';
import 'project/components/app_button_type_template.dart';
import 'project/components/base_scaffold_template.dart';
import 'project/components/base_text_field_template.dart';
import 'project/components/components_index_template.dart';
import 'project/components/loading_indicator_template.dart';
import 'project/components/tab_bar_v1_template.dart';
import 'project/context_extensions_template.dart';
import 'project/core_barrel_template.dart';
import 'project/dark_theme_template.dart';
import 'project/dart_define_docs_template.dart';
import 'project/data_index_template.dart';
import 'project/devtools_options_template.dart';
import 'project/domain_use_case_template.dart';
// Environment templates
import 'project/env_config_template.dart';
import 'project/env_file_template.dart';
import 'project/gitignore_template.dart';
import 'project/light_theme_template.dart';
import 'project/main_dart_template.dart';
import 'project/navigation_index_template.dart';
import 'project/network/api_interceptor_template.dart';
import 'project/network/auth_data_source_template.dart';
import 'project/network/error_response_template.dart';
import 'project/network/interceptor_strings_template.dart';
import 'project/network/network_index_template.dart';
// Network templates
import 'project/network/network_service_template.dart';
import 'project/network/request_method_template.dart';
import 'project/network/success_response_template.dart';
import 'project/pubspec_yaml_template.dart';
import 'project/readme_template.dart';
import 'project/router_template.dart';
import 'project/routes_template.dart';
import 'project/sample_feature_index_template.dart';
import 'project/sample_home_screen_template.dart';
import 'project/string_extensions_template.dart';
import 'project/theme_barrel_template.dart';
import 'project/theme_color_token_template.dart';
import 'project/theme_radius_token_template.dart';
import 'project/theme_text_style_token_template.dart';
import 'project/theme_token_template.dart';
import 'project/utils_index_template.dart';
import 'project/utils/input_field_validator_template.dart';
import 'project/utils/string_extensions_template.dart' as utils_string_ext;
import 'project/utils/validation_index_template.dart';
import 'project/vscode_launch_template.dart';
import 'project/vscode_settings_template.dart';

class ProjectTemplates {
  final ProjectConfig config;

  ProjectTemplates(this.config);

  String get pubspecYaml => pubspecYamlTemplate(config);

  String get mainDart => mainDartTemplate(config);

  String get bootstrap => bootstrapTemplate(config);

  String get appView => appViewTemplate(config);

  String get appConstants => appConstantsTemplate(config);

  String get coreBarrel => coreBarrelTemplate(config);

  String get router => routerTemplate(config);

  String get analysisOptions => analysisOptionsTemplate();

  String get gitignore => gitignoreTemplate();

  String get readme => readmeTemplate(config);

  String get appBarrel => appBarrelTemplate();

  String get themeBarrel => themeBarrelTemplate(config);

  // Theme system templates
  String get themeToken => themeTokenTemplate(config);
  String get themeColorToken => themeColorTokenTemplate(config);
  String get themeTextStyleToken => themeTextStyleTokenTemplate(config);
  String get themeRadiusToken => themeRadiusTokenTemplate(config);
  String get colorValues => colorValuesTemplate(config);
  String get baseTheme => baseThemeTemplate(config);
  String get lightTheme => lightThemeTemplate(config);
  String get darkTheme => darkThemeTemplate(config);

  String get componentsIndex => componentsIndexTemplate(config);

  String get dataIndex => dataIndexTemplate();

  String get domainUseCase => domainUseCaseTemplate();

  String get utilsIndex => utilsIndexTemplate();

  String get navigationIndex => navigationIndexTemplate();

  String get routes => routesTemplate();

  String get blocProvider => projectBlocProviderTemplate();

  String get stringExtensions => stringExtensionsTemplate();

  String get contextExtensions => contextExtensionsTemplate();

  // Validation templates
  String get inputFieldValidator => inputFieldValidatorTemplate(config);
  String get utilsStringExtensions => utils_string_ext.stringExtensionsTemplate(config);
  String get validationIndex => validationIndexTemplate(config);

  // Network templates
  String get networkService => networkServiceTemplate(config);
  String get authDataSource => authDataSourceTemplate(config);
  String get apiInterceptor => apiInterceptorTemplate(config);
  String get interceptorStrings => interceptorStringsTemplate(config);
  String get requestMethod => requestMethodTemplate(config);
  String get errorResponse => errorResponseTemplate(config);
  String get successResponse => successResponseTemplate(config);
  String get networkIndex => networkIndexTemplate(config);

  // Environment templates
  String get envConfig => envConfigTemplate(config);
  String get dartDefineDocs => dartDefineDocsTemplate(config);

  // Component templates
  String get appBarV1 => appbarv1Template(config);
  String get tabBarV1 => tabbarv1Template(config);
  String get appButton => appButtonTemplate(config);
  String get appButtonStyle => appButtonStyleTemplate(config);
  String get appButtonType => appButtonTypeTemplate(config);
  String get baseTextField => baseTextFieldTemplate(config);
  String get baseScaffold => baseScaffoldTemplate(config);
  String get loadingIndicator => loadingIndicatorTemplate(config);

  String get sampleHomeScreen => sampleHomeScreenTemplate(config);

  String get sampleFeatureIndex => sampleFeatureIndexTemplate();

  String get devtoolsOptions => devtoolsOptionsTemplate();

  String get vscodeSettings => vscodeSettingsTemplate();

  String get vscodeLaunch => vscodeLaunchTemplate(config);

  String get envFile => envFileTemplate(config);
}
