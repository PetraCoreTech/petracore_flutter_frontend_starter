
import '../../generators/feature_generator.dart';

String stateTemplate(FeatureConfig config) => '''
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
${config.includeModels ? "import '../../data/models/models.dart';" : ''}

part '${config.featureName}_state.freezed.dart';

@freezed
class ${config.pascalCase}State with _\$${config.pascalCase}State {
  const factory ${config.pascalCase}State.initial() = _Initial;
  const factory ${config.pascalCase}State.loading() = _Loading;
  const factory ${config.pascalCase}State.loaded(${config.includeModels ? 'List<${config.pascalCase}Model>' : 'List<dynamic>'} data) = _Loaded;
  const factory ${config.pascalCase}State.error(String message) = _Error;
}

// Alternative: Using Equatable instead of Freezed
/*
abstract class ${config.pascalCase}State extends Equatable {
  const ${config.pascalCase}State();

  @override
  List<Object?> get props => [];
}

class ${config.pascalCase}Initial extends ${config.pascalCase}State {
  const ${config.pascalCase}Initial();
}

class ${config.pascalCase}Loading extends ${config.pascalCase}State {
  const ${config.pascalCase}Loading();
}

class ${config.pascalCase}Loaded extends ${config.pascalCase}State {
  final ${config.includeModels ? 'List<${config.pascalCase}Model>' : 'List<dynamic>'} data;

  const ${config.pascalCase}Loaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ${config.pascalCase}Error extends ${config.pascalCase}State {
  final String message;

  const ${config.pascalCase}Error(this.message);

  @override
  List<Object?> get props => [message];
}
*/
'''
;