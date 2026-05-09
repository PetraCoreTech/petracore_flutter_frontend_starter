import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String createDtoTemplate(FeatureConfig config) => '''
class Create${config.pascalEntity}Dto {
  Create${config.pascalEntity}Dto();

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }
}
''';
