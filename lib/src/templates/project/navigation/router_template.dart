import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routerTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/main_app/main_app_index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: AppRoutes.entry.path,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.entry.path,
      name: AppRoutes.entry.name,
      builder: (context, state) => const AppEntryScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard.path,
      name: AppRoutes.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
    ),

    // petracore:start:feature_routes
    // petracore:end:feature_routes
  ],
);
''';
