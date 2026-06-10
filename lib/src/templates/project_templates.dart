import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class ProjectTemplates {
  ProjectTemplates(this.config);

  final ProjectConfig config;

  /// Project Files
  String get analysisOptions => analysisOptionsTemplate();
  String get gitignore => gitignoreTemplate();
  String get readme => readmeTemplate(config);
  String get dartDefineDocs => dartDefineDocsTemplate(config);
  String get devtoolsOptions => devtoolsOptionsTemplate();
  String get vscodeSettings => vscodeSettingsTemplate();
  String get vscodeLaunch => vscodeLaunchTemplate(config);
  String get envJson => envJsonTemplate(config);
  String get pubspecYaml => pubspecYamlTemplate(config);
  String get petracoreConfig => petracoreConfigTemplate(config);

  /// Project Config
  String get mainDart => mainDartTemplate(config);
  String get bootstrap => bootstrapTemplate();

  /// App
  String get appBarrel => appBarrelTemplate(config);
  String get appConstants => appConstantsTemplate(config);
  String get contentStrings => contentStringsTemplate();

  /// Core
  String get coreBarrel => coreBarrelTemplate(config);

  /// Core/Data
  String get dataIndex => dataIndexTemplate();
  String get domainUseCase => domainUseCaseTemplate(config);
  String get localAuthData => localAuthDataTemplate();

  /// Core/Data/Enums
  String get requestMethod => requestMethodTemplate();

  /// Core/Data/Models
  String get errorResponse => errorResponseTemplate(config);
  String get successResponse => successResponseTemplate();
  String get baseModel => baseModelTemplate();

  /// Core/Data/Services
  String get apiClientIndex => apiClientIndexTemplate();
  String get apiClient => apiClientTemplate(config);
  String get apiError => apiErrorTemplate(config);
  String get apiInterceptor => apiInterceptorTemplate(config);
  String get interceptorStrings => interceptorStringsTemplate();

  /// Core/Data/Utils
  String get envConfig => envConfigTemplate(config);

  /// Core/Utils
  String get utilsIndex => utilsIndexTemplate();
  String get boolExtension => boolExtensionTemplate();
  String get contextExtensions => contextExtensionsTemplate(config);
  String get ctxResponsiveExt => ctxResponsiveExtTemplate();
  String get dateTimeExtension => dateTimeExtTemplate(config);
  String get intExtension => intExtensionTemplate();
  String get listExtension => listExtensionTemplate();
  String get pageControllerExt => pageControllerExtTemplate();
  String get stringExtension => stringExtensionTemplate();
  String get inputFieldValidator => inputFieldValidatorTemplate(config);
  String get validationIndex => validationIndexTemplate(config);

  /// Navigation
  String get routes => routesTemplate(config);
  String get router => routerTemplate(config);
  String get navigationIndex => navigationIndexTemplate();
  String get routeModel => routeModelTemplate();
  String get func => funcTemplate(config);
  String get navigationExtension => navigationExtTemplate(config);

  /// Shared/Presentation/Controllers
  String get keyValue => keyValueTemplate();
  String get blocProvider => projectBlocProviderTemplate(config);
  String get sharedIndex => sharedIndexTemplate();
  String get typeDef => typeDefTemplate();
}
