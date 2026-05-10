import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routesTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/navigation/models/route_model.dart';

class AppRoutes {
  AppRoutes._();
  
  static const splash = AppRoute(path: '/', name: 'splash');
  
  // Add your route constants here
}
''';
