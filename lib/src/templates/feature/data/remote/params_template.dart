import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String paramsTemplate(FeatureConfig config) => '''
class ${config.pascalEntity}Params {
  ${config.pascalEntity}Params();

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }
}
''';
