import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String petracoreConfigTemplate(ProjectConfig config) {
  final presetStr = config.designPreset;

  return '''
{
  "themeType": "material",
  "designPreset": "$presetStr"
}
''';
}
