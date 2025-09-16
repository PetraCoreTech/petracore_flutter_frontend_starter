import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String envFileTemplate(ProjectConfig config) => '''
{
base_url:'https://api.example.com'
api_timeout:'30000'
APP_ENV:'development'
}

''';
