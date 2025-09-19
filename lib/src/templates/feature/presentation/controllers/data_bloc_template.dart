import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocTemplate(FeatureConfig config) => '''
import 'package:meta/meta.dart';
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

part '${config.featureName}s_event.dart';
part '${config.featureName}s_state.dart';

final ${config.camelCase}sBloc = ${config.pascalCase}sBloc();

class ${config.pascalCase}sBloc extends Bloc<${config.pascalCase}sEvent, ${config.pascalCase}sState> {
  ${config.pascalCase}sBloc() : super(${config.pascalCase}sInitial()) {
    on<Fetch${config.pascalCase}s>(_fetch${config.pascalCase}s);
  }

  Future<void> _fetch${config.pascalCase}s(
    Fetch${config.pascalCase}s event,
    Emitter<${config.pascalCase}sState> emit,
  ) async {
    emit(${config.pascalCase}sLoading());
    final params = ${config.pascalCase}Params();
    final res = await multiple${config.pascalCase}UseCase.call(params);
    res.fold(
      (l) => emit(${config.pascalCase}sLoaded(l)),
      (r) => emit(${config.pascalCase}sError(r)),
    );
  }
}
''';
