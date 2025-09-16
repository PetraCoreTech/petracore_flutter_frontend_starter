import '../../generators/project_generator.dart';

String envConfigTemplate(ProjectConfig config) => '''
/// Environment configuration using dart-define variables for ${config.projectName}
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

  static const bool _debugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );

  static const bool _enableLogging = bool.fromEnvironment(
    'ENABLE_LOGGING',
    defaultValue: true,
  );

  static const String _stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  static const String _googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );

  /// App name
  static String get appName => _appName;

  /// API base URL
  static String get apiBaseUrl => _apiBaseUrl;

  /// API timeout in milliseconds
  static int get apiTimeout => _apiTimeout;

  /// Debug mode flag
  static bool get debugMode => _debugMode;

  /// Enable logging flag
  static bool get enableLogging => _enableLogging;

  /// Stripe publishable key
  static String get stripePublishableKey => _stripePublishableKey;

  /// Google Maps API key
  static String get googleMapsApiKey => _googleMapsApiKey;

  /// Check if running in production mode
  static bool get isProduction => !_debugMode;

  /// Check if running in development mode
  static bool get isDevelopment => _debugMode;

  /// Get all environment variables as a map (useful for debugging)
  static Map<String, dynamic> get allVariables => {
    'APP_NAME': appName,
    'API_BASE_URL': apiBaseUrl,
    'API_TIMEOUT': apiTimeout,
    'DEBUG_MODE': debugMode,
    'ENABLE_LOGGING': enableLogging,
    'STRIPE_PUBLISHABLE_KEY': stripePublishableKey.isNotEmpty ? '***' : 'Not set',
    'GOOGLE_MAPS_API_KEY': googleMapsApiKey.isNotEmpty ? '***' : 'Not set',
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
  static bool get debugMode => EnvConfig.debugMode;
  static bool get enableLogging => EnvConfig.enableLogging;
  static String get stripePublishableKey => EnvConfig.stripePublishableKey;
  static String get googleMapsApiKey => EnvConfig.googleMapsApiKey;
  static bool get isProduction => EnvConfig.isProduction;
  static bool get isDevelopment => EnvConfig.isDevelopment;
}
''';
