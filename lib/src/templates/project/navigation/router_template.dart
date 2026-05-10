import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routerTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/main_app/main_app_index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: AppRoutes.splash.path,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.splash.path,
      name: AppRoutes.splash.name,
      builder: (context, state) => const Placeholder(),
    ),
    GoRoute(
      path: AppRoutes.dashboard.path,
      name: AppRoutes.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
    ),
    
    // Add your feature routes here
  ],
);
''';
