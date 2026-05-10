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
}
