import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String actionBlocTemplate(FeatureConfig config) => '''
import 'package:meta/meta.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

part '${config.featureName}_action_event.dart';
part '${config.featureName}_action_state.dart';

final ${config.camelEntity}ActionBloc = ${config.pascalEntity}ActionBloc();

class ${config.pascalEntity}ActionBloc extends Bloc<${config.pascalEntity}ActionEvent, ${config.pascalEntity}ActionState> {
  ${config.pascalEntity}ActionBloc() : super(${config.pascalEntity}ActionInitial()) {
    on<Create${config.pascalEntity}>(_create${config.pascalEntity});
    on<Delete${config.pascalEntity}>(_delete${config.pascalEntity});
    on<Update${config.pascalEntity}>(_update${config.pascalEntity});
  }

  Future<void> _create${config.pascalEntity}(
    Create${config.pascalEntity} event,
    Emitter<${config.pascalEntity}ActionState> emit,
  ) async {
    emit(${config.pascalEntity}ActionLoading());
    final params = Create${config.pascalEntity}Dto();
    final res = await create${config.pascalEntity}UseCase.call(params);
    res.fold(
      (l) => emit(${config.pascalEntity}Created(l)),
      (r) => emit(${config.pascalEntity}ActionError(r)),
    );
  }

  Future<void> _delete${config.pascalEntity}(
    Delete${config.pascalEntity} event,
    Emitter<${config.pascalEntity}ActionState> emit,
  ) async {
    emit(${config.pascalEntity}ActionLoading());
    final res = await delete${config.pascalEntity}UseCase.call(event.id);
    res.fold(
      (l) => emit(${config.pascalEntity}Deleted(l)),
      (r) => emit(${config.pascalEntity}ActionError(r)),
    );
  }
  
  Future<void> _update${config.pascalEntity}(
    Update${config.pascalEntity} event,
    Emitter<${config.pascalEntity}ActionState> emit,
  ) async {
    emit(${config.pascalEntity}ActionLoading());
    final params = Update${config.pascalEntity}Dto(id: event.id);
    final res = await update${config.pascalEntity}UseCase.call(params);
    res.fold(
      (l) => emit(${config.pascalEntity}Updated(l)),
      (r) => emit(${config.pascalEntity}ActionError(r)),
    );
  }
}  
''';
