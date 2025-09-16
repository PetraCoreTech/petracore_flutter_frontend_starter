import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

import 'feature/bloc_provider_template.dart';
import 'feature/controllers_barrel_template.dart';
import 'feature/cubit_template.dart';
import 'feature/data_model_template.dart';
import 'feature/dto_barrel_template.dart';
import 'feature/dto_template.dart';
import 'feature/feature_index_template.dart';
import 'feature/get_use_case_template.dart';
import 'feature/models_barrel_template.dart';
import 'feature/presentation_barrel_template.dart';
import 'feature/remote_barrel_template.dart';
import 'feature/repositories_barrel_template.dart';
import 'feature/repository_template.dart';
import 'feature/screen_template.dart';
import 'feature/screens_barrel_template.dart';
import 'feature/service_template.dart';
import 'feature/state_template.dart';
import 'feature/use_cases_barrel_template.dart';
import 'feature/widget_template.dart';
import 'feature/widgets_barrel_template.dart';

class FeatureTemplates {
  FeatureTemplates(this.config);

  final FeatureConfig config;

  String get featureIndex => featureIndexTemplate(config);

  String get dataModel => dataModelTemplate(config);

  String get modelsBarrel => modelsBarrelTemplate(config);

  String get repository => repositoryTemplate(config);

  String get repositoriesBarrel => repositoriesBarrelTemplate(config);

  String get getUseCase => getUseCaseTemplate(config);

  String get useCasesBarrel => useCasesBarrelTemplate(config);

  String get cubit => cubitTemplate(config);

  String get state => stateTemplate(config);

  String get blocProvider => blocProviderTemplate(config);

  String get controllersBarrel => controllersBarrelTemplate(config);

  String get screen => screenTemplate(config);

  String get widget => widgetTemplate(config);

  String get screensBarrel => screensBarrelTemplate(config);

  String get widgetsBarrel => widgetsBarrelTemplate(config);

  String get presentationBarrel => presentationBarrelTemplate(config);

  String get service => serviceTemplate(config);

  String get dto => dtoTemplate(config);

  String get dtoBarrel => dtoBarrelTemplate(config);

  String get remoteBarrel => remoteBarrelTemplate(config);
}
