import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class FeatureTemplates {
  FeatureTemplates(this.config);

  final FeatureConfig config;

  ProjectConfig get projectConfig => config.projectConfig;

  /// Feature
  String get featureIndex => featureIndexTemplate(config);

  /// Feature/Data
  String get dataModel => dataModelTemplate(config);
  String get createDto => createDtoTemplate(config);
  String get updateDto => updateDtoTemplate(config);
  String get params => paramsTemplate(config);
  String get repository => repositoryTemplate(config);
  String get service => serviceTemplate(projectConfig, config);
  String get repositoriesBarrel => repositoriesBarrelTemplate(config);
  String get useCases => useCasesTemplate(config);

  /// Feature/Presentation
  String get actionBloc => actionBlocTemplate(config);
  String get actionBlocEvent => actionBlocEventTemplate(config);
  String get actionBlocState => actionBlocStateTemplate(config);
  String get dataBloc => dataBlocTemplate(config);
  String get dataBlocEvent => dataBlocEventTemplate(config);
  String get dataBlocState => dataBlocStateTemplate(config);
  String get cubit => cubitTemplate(config);
  String get blocProvider => blocProviderTemplate(config);
  String get controllersBarrel => controllersBarrelTemplate(config);
  String get screen => screenTemplate(config);
  String get listScreen => listScreenTemplate(config);
  String get screensBarrel => screensBarrelTemplate(config);
  String get presentationBarrel => presentationBarrelTemplate(config);

  /// Pagination Feature
  String get paginationIndex => paginationIndexTemplate(projectConfig.projectName);
  String get paginationBloc => paginationBlocTemplate(projectConfig.projectName);
  String get paginationEvent => paginationEventTemplate(projectConfig.projectName);
  String get paginationState => paginationStateTemplate(projectConfig.projectName);
  String get paginatedListView => paginatedListViewTemplate(projectConfig.projectName);
  String get paginatedListBuilder => paginatedListBuilderTemplate(projectConfig.projectName);

  /// Notification Feature
  String get notificationIndex => notificationIndexTemplate(projectConfig.projectName);
  String get notificationCubit => notificationCubitTemplate(projectConfig.projectName);
  String get notificationBlocProvider => notificationBlocProviderTemplate(projectConfig.projectName);
  String get notificationControllerIndex => notificationControllerIndexTemplate(projectConfig.projectName);
  String get notificationItemEntity => notificationItemEntityTemplate(projectConfig.projectName);
  String get notificationTypeEntity => notificationTypeEntityTemplate(projectConfig.projectName);
  String get notificationBadge => notificationBadgeTemplate(projectConfig.projectName);
  String get notificationCard => notificationCardTemplate(projectConfig.projectName);
  String get notificationList => notificationListTemplate(projectConfig.projectName);
  String get notificationTile => notificationTileTemplate(projectConfig.projectName);

  /// Survey Feature
  String get surveyIndex => surveyIndexTemplate(projectConfig.projectName);
  String get surveyModeCubit => surveyModeCubitTemplate(projectConfig.projectName);
  String get surveyBlocProvider => surveyBlocProviderTemplate(projectConfig.projectName);
  String get surveyControllerIndex => surveyControllerIndexTemplate(projectConfig.projectName);
  String get surveyAnswerEntity => surveyAnswerEntityTemplate(projectConfig.projectName);
  String get surveyQuestionEntity => surveyQuestionEntityTemplate(projectConfig.projectName);
  String get surveyModeEnum => surveyModeEnumTemplate(projectConfig.projectName);
  String get surveyBuilder => surveyBuilderTemplate(projectConfig.projectName);
  String get surveyOverviewMode => overviewModeTemplate(projectConfig.projectName);
  String get surveyQuestionMode => questionModeTemplate(projectConfig.projectName);
  String get surveyAnswerDisplay => surveyAnswerDisplayTemplate(projectConfig.projectName);
  String get surveyQuestionDisplay => surveyQuestionDisplayTemplate(projectConfig.projectName);
  String get surveyOptionSelector => surveyOptionSelectorTemplate(projectConfig.projectName);
}
