import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String splashScreenTemplate(ProjectConfig config) => '''
import 'dart:async';

import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 2200), _navigate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashLogo(
          icon: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFE3F2FD)],
                stops: [0.0, 0.5],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: const Offset(8, 12),
                  blurRadius: 20,
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.3),
                  offset: const Offset(-4, -4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF1565C0),
                  Color(0xFF1A237E),
                ],
              ).createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Icon(Icons.flutter_dash, size: 92),
              ),
            ),
          ),
          text: '${config.className}',
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
      ToastHelper.showInfo(context, 'Welcome back!');
      context.goNamed(AppRoutes.dashboard.name);
    } else if (lastStatus.isLoggedOut) {
      context.goNamed(AppRoutes.login.name);
    }
  }
}
''';
