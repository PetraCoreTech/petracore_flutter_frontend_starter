import 'package:petracore_flutter_frontend_starter/src/generators/feature_generator.dart';

String cubitTemplate(FeatureConfig config) => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
${config.includeModels ? "import '../../data/models/models.dart';" : ''}
${config.includeUseCases ? "import '../../data/use_cases/use_cases.dart';" : ''}
import '${config.featureName}_state.dart';

class ${config.pascalCase}Cubit extends Cubit<${config.pascalCase}State> {
${config.includeUseCases ? '  final Get${config.pascalCase}UseCase _get${config.pascalCase}UseCase;' : ''}

  ${config.pascalCase}Cubit(${config.includeUseCases ? 'this._get${config.pascalCase}UseCase' : ''}) : super(const ${config.pascalCase}State.initial());

  Future<void> load${config.pascalCase}Data() async {
    emit(const ${config.pascalCase}State.loading());
    
    try {
${config.includeUseCases ? '''      final result = await _get${config.pascalCase}UseCase();
      
      result.fold(
        (error) => emit(${config.pascalCase}State.error(error)),
        (data) => emit(${config.pascalCase}State.loaded(data)),
      );''' : '''      // TODO: Implement data loading logic
      emit(const ${config.pascalCase}State.loaded([]));'''}
    } catch (e) {
      emit(${config.pascalCase}State.error('Failed to load ${config.featureName}: \$e'));
    }
  }

  void refresh() {
    load${config.pascalCase}Data();
  }
}
''';
