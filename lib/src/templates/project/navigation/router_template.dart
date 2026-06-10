import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routerTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/auth/auth_index.dart';
import 'package:${config.packageName}/features/main_app/main_app_index.dart';
import 'package:${config.packageName}/navigation/routes/auth_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: AppRoutes.entry.path,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.entry.path,
      name: AppRoutes.entry.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.dashboard.path,
      name: AppRoutes.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
    ),

    // petracore:start:feature_routes

    ...authRoutes,
// petracore:end:feature_routes
  ],
);
''';
