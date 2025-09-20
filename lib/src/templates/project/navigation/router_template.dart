import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routerTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/navigation/navigation_index.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const Placeholder(),
    ),
  ],
);
''';
