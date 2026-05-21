import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String petracoreConfigTemplate(ProjectConfig config) {
  final themeStr = config.themeType == ThemeType.material ? 'material' : 'mix';
  final presetStr = config.designPreset.name;

  return '''
{
  "themeType": "$themeStr",
  "designPreset": "$presetStr"
}
''';
}
