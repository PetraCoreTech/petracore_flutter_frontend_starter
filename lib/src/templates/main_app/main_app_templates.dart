import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';
import 'package:petracore_flutter_frontend_starter/src/templates/template_index.dart';

class MainAppTemplates {
  MainAppTemplates(this.config);

  final ProjectConfig config;

  String get mainAppIndex => mainAppIndexTemplate();
  String get presentationBarrel => mainAppPresentationBarrelTemplate();
  String get controllerIndex => mainAppControllerIndexTemplate();
  String get blocProvider => mainAppBlocProviderTemplate();
  String get dashboardScreen => materialDashboardScreenTemplate(config);
  String get appEntryScreen => materialAppEntryScreenTemplate(config);
}
