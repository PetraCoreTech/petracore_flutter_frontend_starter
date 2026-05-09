import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String dataModelTemplate(FeatureConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';

part '${config.entityName}_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ${config.pascalEntity} extends BaseModel {
  const ${config.pascalEntity} ({
    required super.id,
   super.dateCreated,
   super.lastUpdated,
  });

  factory ${config.pascalEntity}.fromJson(Map<String, dynamic> json) =>
      _\$${config.pascalEntity}FromJson(json);
      
  Map<String, dynamic> toJson() => _\$${config.pascalEntity}ToJson(this);
      
  static ${config.pascalEntity}? maybeFromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return ${config.pascalEntity}.fromJson(json);
    }
    return null;
  }
}
''';
