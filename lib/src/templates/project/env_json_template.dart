import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String envJsonTemplate(ProjectConfig config) => '''
{
  "APP_NAME": "${config.projectName}",
  "API_BASE_URL": "https://api.${config.projectName.toLowerCase()}.com",
  "API_TIMEOUT": 30000,
  "ENABLE_LOGGING": true
}
''';
