
import '../../generators/feature_generator.dart';

String dtoTemplate(FeatureConfig config) => '''
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/models.dart';

part '${config.featureName}_dto.freezed.dart';
part '${config.featureName}_dto.g.dart';

@freezed
class ${config.pascalCase}Dto with _\$${config.pascalCase}Dto {
  const factory ${config.pascalCase}Dto({
    required String id,
    required String name,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _${config.pascalCase}Dto;

  factory ${config.pascalCase}Dto.fromJson(Map<String, dynamic> json) =>
      _\$${config.pascalCase}DtoFromJson(json);
}

extension ${config.pascalCase}DtoX on ${config.pascalCase}Dto {
  ${config.pascalCase}Model toModel() {
    return ${config.pascalCase}Model(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ${config.pascalCase}ModelX on ${config.pascalCase}Model {
  ${config.pascalCase}Dto toDto() {
    return ${config.pascalCase}Dto(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
'''
;