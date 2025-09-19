import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String dartDefineDocsTemplate(ProjectConfig config) => '''
# Environment Configuration with dart-define

This project uses Dart's `--dart-define` feature for environment variables. This approach allows you to pass configuration values at build/run time without storing sensitive information in your codebase.

## Available Environment Variables

| Variable | Type | Default Value | Description |
|----------|------|---------------|-------------|
| `BASE_URL` | String | `https://api.${config.projectName.toLowerCase()}.com` | Base URL for API calls |
| `API_TIMEOUT` | int | `30000` | API request timeout in milliseconds |
| `ENABLE_LOGGING` | bool | `true` | Enable/disable logging |
| `GOOGLE_MAPS_API_KEY` | String | `""` | Google Maps API key |

## Usage

### Development
```bash
flutter run --dart-define-from-file=env.json
```

### Production
```bash
flutter run --dart-define-from-file=env.json
```

### Using in Code

```dart
import 'package:${config.packageName}/core/utils/env_config.dart';

// Use the shorthand Env class
void main() {
  print('App Name: \${Env.appName}');
  print('API URL: \${Env.apiBaseUrl}');
  print('Debug Mode: \${Env.debugMode}');
  
  // Or use the full EnvConfig class
  print('Timeout: \${EnvConfig.apiTimeout}');
  
  // Debug all variables
  if (Env.isDevelopment) {
    EnvConfig.printVariables();
  }
}
```

## Network Service Integration

The environment variables are automatically used in the api_client service:

```dart
// In network_service.dart
final baseOptions = BaseOptions(
  baseUrl: Env.apiBaseUrl,  // Uses dart-define value
  connectTimeout: Duration(milliseconds: Env.apiTimeout),
);
```

## Security Notes

1. **Never commit sensitive values** to version control
2. **Use environment variables or CI/CD secrets** for production builds
3. **Stripe keys and API keys** should be passed via build scripts or CI/CD
4. **The dart-define values are compiled into the app**, so they're not runtime configurable

## Best Practices

1. Always provide sensible default values
2. Use descriptive variable names with consistent naming convention
3. Group related variables logically
4. Document all available variables and their purposes
5. Use build scripts to manage complex configurations
''';
