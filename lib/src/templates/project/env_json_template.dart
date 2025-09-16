import '../../generators/project_generator.dart';

String envJsonTemplate(ProjectConfig config) => '''
{
  "app_name": "${config.projectName}",
  "api_base_url": "https://api.${config.projectName.toLowerCase()}.com",
  "api_timeout": 30000,
  "debug_mode": true,
  "enable_logging": true
}
''';
