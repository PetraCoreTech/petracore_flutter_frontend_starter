import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocTemplate(FeatureConfig config) => '''
import 'package:meta/meta.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

part '${config.featureName}_action_event.dart';
part '${config.featureName}_action_state.dart';

final ${config.camelCase}ActionBloc = ${config.pascalCase}ActionBloc();

class ${config.pascalCase}ActionBloc extends Bloc<${config.pascalCase}ActionEvent, ${config.pascalCase}ActionState> {
  ${config.pascalCase}ActionBloc() : super(${config.pascalCase}ActionInitial()) {
    on<Create${config.pascalCase}>(_create${config.pascalCase});
    on<Delete${config.pascalCase}>(_delete${config.pascalCase});
    on<Update${config.pascalCase}>(_update${config.pascalCase});
  }

  Future<void> _create${config.pascalCase}(
    Create${config.pascalCase} event,
    Emitter<${config.pascalCase}ActionState> emit,
  ) async {
    emit(${config.pascalCase}ActionLoading());
    final params = Create${config.pascalCase}Dto();
    final res = await create${config.pascalCase}UseCase.call(params);
    res.fold(
      (l) => emit(${config.pascalCase}Created(l)),
      (r) => emit(${config.pascalCase}ActionError(r)),
    );
  }

  Future<void> _delete${config.pascalCase}(
    Delete${config.pascalCase} event,
    Emitter<${config.pascalCase}ActionState> emit,
  ) async {
    emit(${config.pascalCase}ActionLoading());
    final res = await delete${config.pascalCase}UseCase.call(event.id);
    res.fold(
      (l) => emit(${config.pascalCase}Deleted(l)),
      (r) => emit(${config.pascalCase}ActionError(r)),
    );
  }
  
  Future<void> _update${config.pascalCase}(
    Update${config.pascalCase} event,
    Emitter<${config.pascalCase}ActionState> emit,
  ) async {
    emit(${config.pascalCase}ActionLoading());
    final params = Update${config.pascalCase}Dto();
    final res = await update${config.pascalCase}UseCase.call(params);
    res.fold(
      (l) => emit(${config.pascalCase}Updated(l)),
      (r) => emit(${config.pascalCase}ActionError(r)),
    );
  }
''';
