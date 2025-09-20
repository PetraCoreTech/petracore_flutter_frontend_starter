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

  /// Project Config
  String get mainDart => mainDartTemplate(config);
  String get bootstrap => bootstrapTemplate();

  /// App
  String get appBarrel => appBarrelTemplate();
  String get appView => appViewTemplate(config);
  String get appConstants => appConstantsTemplate(config);
  String get contentStrings => contentStringsTemplate();

  /// App/Theme
  String get themeBarrel => themeBarrelTemplate();
  String get colorValues => colorValuesTemplate();
  String get themeToken => themeTokenTemplate();
  String get themeColorToken => themeColorTokenTemplate();
  String get themeTextStyleToken => themeTextStyleTokenTemplate();
  String get themeRadiusToken => themeRadiusTokenTemplate();
  String get baseTheme => baseThemeTemplate(config);
  String get lightTheme => lightThemeTemplate(config);
  String get darkTheme => darkThemeTemplate(config);

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
  String get contextExtensions => contextExtensionsTemplate();
  String get ctxResponsiveExt => ctxResponsiveExtTemplate();
  String get dateTimeExtension => dateTimeExtTemplate(config);
  String get intExtension => intExtensionTemplate();
  String get listExtension => listExtensionTemplate();
  String get pageControllerExt => pageControllerExtTemplate();
  String get stringExtension => stringExtensionTemplate();
  String get inputFieldValidator => inputFieldValidatorTemplate(config);
  String get validationIndex => validationIndexTemplate(config);

  /// Core/Component
  String get componentsIndex => componentsIndexTemplate(config);

  /// Core/Component/AppBar
  String get appBarV1 => appBarV1Template(config);
  String get persistentHeaderV1 => persistentHeaderV1Template(config);
  String get tabBarV1 => tabBarV1Template(config);

  /// Core/Component/Buttons
  String get appButton => appButtonTemplate(config);
  String get appButtonStyle => appButtonStyleTemplate();
  String get appButtonType => appButtonTypeTemplate();
  String get appOutlineButton => appOutlineButtonTemplate(config);
  String get appOutlineButtonStyle => appOutlineButtonStyleTemplate();
  String get appOutlineButtonType => appOutlineButtonTypeTemplate();
  String get appTextButton => appTextButtonTemplate(config);
  String get appTextButtonStyle => appTextButtonStyleTemplate();
  String get appTextButtonType => appTextButtonTypeTemplate();

  ///Core/Component/Custom
  String get customIcon => customIconTemplate();
  String get dividerV1 => dividerV1Template(config);
  String get dot => dotTemplate(config);
  String get expansionTileV1 => expansionTileV1Template(config);
  String get hyperLinkText => hyperLinkTextTemplate(config);
  String get initialsDisplay => initialsDisplayTemplate(config);
  String get listTileV1 => listTileV1Template(config);
  String get passwordStrengthChecker => passwordStrengthCheckerTemplate(config);

  /// Core/Component/Dialog
  String get actionDialog => actionDialogTemplate(config);
  String get bottomSheetSelectContent =>
      bottomSheetSelectContentTemplate(config);
  String get toastV1 => toastV1Template(config);

  /// Core/Component/Frames
  String get iconFrame => iconFrameTemplate(config);
  String get listFrame => listFrameTemplate(config);
  String get profileFrame => profileFrameTemplate(config);
  String get screenFrame => screenFrameTemplate(config);

  /// Core/Component/Helpers
  String get dateTimeHelper => dateTimeHelperTemplate(config);
  String get dialogHelper => dialogHelperTemplate(config);
  String get interactionHelper => interactionHelperTemplate(config);
  String get sliverHelper => sliverHelperTemplate(config);
  String get snackBarHelper => snackBarHelperTemplate(config);
  String get toastHelper => toastHelperTemplate(config);

  /// Core/Component/InputFields
  String get baseTextField => baseTextFieldTemplate(config);
  String get inputField => inputFieldTemplate(config);
  String get inputItem => inputItemTemplate(config);
  String get passwordField => passwordFieldTemplate(config);
  String get phoneField => phoneFieldTemplate(config);
  String get searchFeatureField => searchFeatureFieldTemplate(config);
  String get searchInputField => searchInputFieldTemplate(config);

  /// Core/Component/Scaffolds
  String get baseScaffold => baseScaffoldTemplate();
  String get scaffoldV1 => scaffoldV1Template(config);

  /// Core/Component/States
  String get infoDisplay => infoDisplayTemplate(config);
  String get loadingIndicator => loadingIndicatorTemplate(config);
  String get loadingOverlayV1 => loadingOverlayV1Template(config);
  String get loadingShimmer => loadingShimmerTemplate(config);

  /// Navigation
  String get routes => routesTemplate();
  String get router => routerTemplate(config);
  String get navigationIndex => navigationIndexTemplate();
  String get routeModel => routeModelTemplate();
  String get func => funcTemplate(config);
  String get navigationExtension => navigationExtTemplate(config);

  /// Shared/Presentation/Controllers
  String get keyValue => keyValueTemplate();
  String get blocProvider => projectBlocProviderTemplate();
  String get sharedIndex => sharedIndexTemplate();
  String get typeDef => typeDefTemplate();
}
