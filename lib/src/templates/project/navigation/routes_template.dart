import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String routesTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/navigation/models/route_model.dart';

class AppRoutes {
  AppRoutes._();
  
  static const entry = AppRoute(path: '/', name: 'entry');
  static const dashboard = AppRoute(path: '/dashboard', name: 'dashboard');
  
  // petracore:start:route_constants
static const splash = AppRoute(path: '/', name: 'splash');
  static const welcome = AppRoute(path: '/welcome', name: 'welcome');
  static const login = AppRoute(path: 'login', name: 'login');
  static const signup = AppRoute(path: 'signup', name: 'signup');
  static const verifyOtp = AppRoute(path: 'verify-otp', name: 'verifyOtp');
  static const forgotPassword = AppRoute(path: 'forgot-password', name: 'forgotPassword');
  static const forgotPasswordVerify = AppRoute(path: 'forgot-password-verify', name: 'forgotPasswordVerify');
  static const resetPassword = AppRoute(path: 'reset-password', name: 'resetPassword');
// petracore:end:route_constants
}
''';
