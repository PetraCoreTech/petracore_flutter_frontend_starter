import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String cubitTemplate(FeatureConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';
import 'package:${config.projectConfig.projectName}/features/shared/shared_index.dart';

final ${config.camelCase}Cubit = ${config.pascalCase}Cubit();

class ${config.pascalCase}Cubit extends Cubit<${config.pascalCase}?> with HydratedMixin {
  ${config.pascalCase}Cubit() : super(null) {
    hydrate();
  }

  void set${config.pascalCase}(${config.pascalCase} value) => emit(value);

  void reset() => emit(null);

  @override
  ${config.pascalCase}? fromJson(Map<String, dynamic> json) =>
      ${config.pascalCase}.maybeFromJson(json[KeyValues.value] as Json?);

  @override
  Map<String, dynamic>? toJson(${config.pascalCase}? state) {
    final json = Json();
    json[KeyValues.value] = state?.toJson();
    return json;
  }
}
''';
