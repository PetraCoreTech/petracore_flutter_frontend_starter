import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authRoutesTemplate(ProjectConfig config) => '''
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';

final authRoutes = <GoRoute>[
  GoRoute(
    path: AppRoutes.welcome.path,
    name: AppRoutes.welcome.name,
    builder: (context, state) => const WelcomeScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.forgotPassword.path,
            name: AppRoutes.forgotPassword.name,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: AppRoutes.forgotPasswordVerify.path,
            name: AppRoutes.forgotPasswordVerify.name,
            builder: (context, state) => const ForgotPasswordVerifyScreen(),
          ),
          GoRoute(
            path: AppRoutes.resetPassword.path,
            name: AppRoutes.resetPassword.name,
            builder: (context, state) => const ResetPasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.signup.path,
        name: AppRoutes.signup.name,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
  ),
];
''';
