import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class ProjectTemplates {
  ProjectTemplates(this.config);

  final ProjectConfig config;

  bool get _isMaterial => config.themeType == ThemeType.material;

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
  String get appView => _isMaterial
      ? materialAppViewTemplate(config)
      : appViewTemplate(config);
  String get appConstants => appConstantsTemplate(config);
  String get contentStrings => contentStringsTemplate();

  /// App/Theme
  String get themeBarrel => _isMaterial
      ? materialThemeBarrelTemplate()
      : themeBarrelTemplate();
  String get colorValues => colorValuesTemplate();
  String get themeToken => themeTokenTemplate();
  String get themeColorToken => themeColorTokenTemplate();
  String get themeTextStyleToken => themeTextStyleTokenTemplate();
  String get themeRadiusToken => themeRadiusTokenTemplate();
  String get baseTheme => baseThemeTemplate(config);
  String get lightTheme => lightThemeTemplate(config);
  String get darkTheme => darkThemeTemplate(config);
  String get materialTheme => materialThemeTemplate(config);

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

  /// Core/Component
  String get componentsIndex => componentsIndexTemplate(config);

  /// Core/Component/AppBar
  String get appBarV1 => _isMaterial
      ? materialAppBarV1Template(config)
      : appBarV1Template(config);
  String get persistentHeaderV1 => persistentHeaderV1Template(config);
  String get tabBarV1 => _isMaterial
      ? materialTabBarV1Template(config)
      : tabBarV1Template(config);

  /// Core/Component/Buttons
  String get appButton => _isMaterial
      ? materialAppButtonTemplate(config)
      : appButtonTemplate(config);
  String get appButtonStyle => _isMaterial ? '' : appButtonStyleTemplate();
  String get appButtonType => _isMaterial
      ? materialAppButtonTypeTemplate()
      : appButtonTypeTemplate();
  String get appOutlineButton => _isMaterial
      ? materialAppOutlineButtonTemplate(config)
      : appOutlineButtonTemplate(config);
  String get appOutlineButtonStyle =>
      _isMaterial ? '' : appOutlineButtonStyleTemplate();
  String get appOutlineButtonType => _isMaterial
      ? materialAppOutlineButtonTypeTemplate()
      : appOutlineButtonTypeTemplate();
  String get appTextButton => _isMaterial
      ? materialAppTextButtonTemplate(config)
      : appTextButtonTemplate(config);
  String get appTextButtonStyle => _isMaterial ? '' : appTextButtonStyleTemplate();
  String get appTextButtonType => _isMaterial
      ? materialAppTextButtonTypeTemplate()
      : appTextButtonTypeTemplate();

  ///Core/Component/Custom
  String get customIcon => customIconTemplate();
  String get dividerV1 => _isMaterial
      ? materialDividerV1Template(config)
      : dividerV1Template(config);
  String get dot =>
      _isMaterial ? materialDotTemplate(config) : dotTemplate(config);
  String get expansionTileV1 => _isMaterial
      ? materialExpansionTileV1Template(config)
      : expansionTileV1Template(config);
  String get hyperLinkText => _isMaterial
      ? materialHyperLinkTextTemplate(config)
      : hyperLinkTextTemplate(config);
  String get initialsDisplay => _isMaterial
      ? materialInitialsDisplayTemplate(config)
      : initialsDisplayTemplate(config);
  String get listTileV1 => _isMaterial
      ? materialListTileV1Template(config)
      : listTileV1Template(config);
  String get passwordStrengthChecker => _isMaterial
      ? materialPasswordStrengthCheckerTemplate(config)
      : passwordStrengthCheckerTemplate(config);

  /// Core/Component/Dialog
  String get actionDialog => _isMaterial
      ? materialActionDialogTemplate(config)
      : actionDialogTemplate(config);
  String get bottomSheetSelectContent => _isMaterial
      ? materialBottomSheetSelectContentTemplate(config)
      : bottomSheetSelectContentTemplate(config);
  String get toastV1 =>
      _isMaterial ? materialToastV1Template(config) : toastV1Template(config);

  /// Core/Component/Frames
  String get iconFrame => iconFrameTemplate(config);
  String get listFrame => _isMaterial
      ? materialListFrameTemplate(config)
      : listFrameTemplate(config);
  String get profileFrame => _isMaterial
      ? materialProfileFrameTemplate(config)
      : profileFrameTemplate(config);
  String get screenFrame => _isMaterial
      ? materialScreenFrameTemplate(config)
      : screenFrameTemplate(config);

  /// Core/Component/Helpers
  String get dateTimeHelper => _isMaterial
      ? materialDateTimeHelperTemplate(config)
      : dateTimeHelperTemplate(config);
  String get dialogHelper => _isMaterial
      ? materialDialogHelperTemplate(config)
      : dialogHelperTemplate(config);
  String get interactionHelper => interactionHelperTemplate(config);
  String get sliverHelper => _isMaterial
      ? materialSliverHelperTemplate(config)
      : sliverHelperTemplate(config);
  String get snackBarHelper => _isMaterial
      ? materialSnackBarHelperTemplate(config)
      : snackBarHelperTemplate(config);
  String get toastHelper => _isMaterial
      ? materialToastHelperTemplate(config)
      : toastHelperTemplate(config);

  /// Core/Component/InputFields
  String get baseTextField => _isMaterial
      ? materialBaseTextFieldTemplate(config)
      : baseTextFieldTemplate(config);
  String get inputField => _isMaterial
      ? materialInputFieldTemplate(config)
      : inputFieldTemplate(config);
  String get inputItem => inputItemTemplate(config);
  String get passwordField => passwordFieldTemplate(config);
  String get phoneField => _isMaterial
      ? materialPhoneFieldTemplate(config)
      : phoneFieldTemplate(config);
  String get searchFeatureField => _isMaterial
      ? materialSearchFeatureFieldTemplate(config)
      : searchFeatureFieldTemplate(config);
  String get searchInputField => searchInputFieldTemplate(config);

  /// Core/Component/Scaffolds
  String get baseScaffold => baseScaffoldTemplate();
  String get scaffoldV1 => _isMaterial
      ? materialScaffoldV1Template(config)
      : scaffoldV1Template(config);

  /// Core/Component/States
  String get infoDisplay => _isMaterial
      ? materialInfoDisplayTemplate(config)
      : infoDisplayTemplate(config);
  String get loadingIndicator => loadingIndicatorTemplate(config);
  String get loadingOverlayV1 => loadingOverlayV1Template(config);
  String get loadingShimmer => _isMaterial
      ? materialLoadingShimmerTemplate(config)
      : loadingShimmerTemplate(config);

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
