import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String envConfigTemplate(ProjectConfig config) => '''
/// 
/// Usage:
/// flutter run --dart-define=API_BASE_URL=https://api.example.com --dart-define=DEBUG_MODE=true
/// flutter build apk --dart-define=API_BASE_URL=https://prod-api.example.com --dart-define=DEBUG_MODE=false
class EnvConfig {
  EnvConfig._();
  
  static const String _appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: '${config.projectName}',
  );

  static const String _apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.${config.projectName.toLowerCase()}.com',
  );

  static const int _apiTimeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30000,
  );

  static const bool _enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );
  
  /// App name
  static String get appName => _appName;

  /// API base URL
  static String get apiBaseUrl => _apiBaseUrl;

  /// API timeout in milliseconds
  static int get apiTimeout => _apiTimeout;


  /// Enable logging flag
  static bool get enableLogging => _enableLogging;

  /// Get all environment variables as a map (useful for debugging)
  static Map<String, dynamic> get allVariables => {
    'APP_NAME': appName,
    'API_BASE_URL': apiBaseUrl,
    'API_TIMEOUT': apiTimeout,
    'ENABLE_LOGGING': enableLogging,
  };

  /// Print all environment variables (useful for debugging)
  static void printVariables() {
    print('📋 Environment Variables:');
    allVariables.forEach((key, value) {
      print('   \$key: \$value');
    });
  }
}

/// Global shorthand for easy access
class Env {
  static String get appName => EnvConfig.appName;
  static String get apiBaseUrl => EnvConfig.apiBaseUrl;
  static int get apiTimeout => EnvConfig.apiTimeout;
  static bool get enableLogging => EnvConfig.enableLogging;
}
''';
