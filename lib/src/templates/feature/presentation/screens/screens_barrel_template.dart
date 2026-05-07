import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String screensBarrelTemplate(FeatureConfig config) {
  final featureName = config.featureName;
  return '''
export '${featureName}_screen.dart';
${config.includeList ? "export '${featureName}_list_screen.dart';" : ""}
''';
}
