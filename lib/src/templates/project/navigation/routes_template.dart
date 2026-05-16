import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routesTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/navigation/models/route_model.dart';

class AppRoutes {
  AppRoutes._();
  
  static const entry = AppRoute(path: '/', name: 'entry');
  static const dashboard = AppRoute(path: '/dashboard', name: 'dashboard');
  
  // petracore:start:route_constants
  // petracore:end:route_constants
}
''';
