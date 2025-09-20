import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String dataModelTemplate(FeatureConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';

part '${config.featureName}_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ${config.pascalCase} extends BaseModel {
  const ${config.pascalCase} ({
    required super.id,
   super.dateCreated,
   super.lastUpdated,
  });

  factory ${config.pascalCase}.fromJson(Map<String, dynamic> json) =>
      _\$${config.pascalCase}FromJson(json);
      
  Map<String, dynamic> toJson() => _\$${config.pascalCase}ToJson(this);
      
  static ${config.pascalCase}? maybeFromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return ${config.pascalCase}.fromJson(json);
    }
    return null;
  }
}
''';
