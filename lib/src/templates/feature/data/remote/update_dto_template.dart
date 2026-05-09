import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String updateDtoTemplate(FeatureConfig config) => '''
class Update${config.pascalEntity}Dto {
  Update${config.pascalEntity}Dto({required this.id});
  final String id;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    return json;
  }
}
''';
