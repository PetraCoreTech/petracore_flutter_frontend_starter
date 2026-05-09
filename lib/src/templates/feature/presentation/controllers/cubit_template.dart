import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String cubitTemplate(FeatureConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';
import 'package:${config.projectConfig.projectName}/features/shared/shared_index.dart';

final ${config.camelEntity}Cubit = ${config.pascalEntity}Cubit();

class ${config.pascalEntity}Cubit extends Cubit<${config.pascalEntity}?> with HydratedMixin {
  ${config.pascalEntity}Cubit() : super(null) {
    hydrate();
  }

  void set${config.pascalEntity}(${config.pascalEntity} value) => emit(value);

  void reset() => emit(null);

  @override
  ${config.pascalEntity}? fromJson(Map<String, dynamic> json) =>
      ${config.pascalEntity}.maybeFromJson(json[KeyValues.value] as Json?);

  @override
  Map<String, dynamic>? toJson(${config.pascalEntity}? state) {
    final json = Json();
    json[KeyValues.value] = state?.toJson();
    return json;
  }
}
''';
