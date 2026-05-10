import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String splashScreenTemplate(ProjectConfig config) => '''
import 'dart:async';

import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/app/app.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/navigation/navigation_index.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(const Duration(milliseconds: 1000), _navigate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldV1(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Brand
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colors.primary.resolve(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.flutter_dash,
                size: 64,
                color: Colors.white,
              ),
            ),
            const Gap(24),
            Text(
              '${config.className}',
              style: \$token.textStyle.heading3.resolve(context).copyWith(
                color: colors.onSurfaceLight.resolve(context),
              ),
            ),
            const Gap(8),
            Text(
              'Welcome to your app',
              style: \$token.textStyle.heading4.resolve(context).copyWith(
                color: colors.onSurfaceLight.resolve(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigate() async {
    final authHistory = context.read<AuthHistoryCubit>().state;
    if (authHistory.isEmpty) {
      context.goNamed(AppRoutes.welcome.name);
      return;
    }
    final lastStatus = authHistory.last.authStatus;
    if (lastStatus.isLoggedIn) {
      ToastHelper(context).showToast(content: '<ContentString.welcome>');
      context.goNamed(AppRoutes.dashboard.name);
    } else if (lastStatus.isLoggedOut) {
      final path = AppRoutes.splash.path.add(AppRoutes.getStarted.name, separator: '/');
      context.go(path);
    }
  }
}
''';
