import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String paramsTemplate(FeatureConfig config) => '''
class ${config.pascalCase}Params {
  ${config.pascalCase}Params();

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return data;
  }
}
''';
