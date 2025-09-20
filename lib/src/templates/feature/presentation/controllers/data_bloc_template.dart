import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocTemplate(FeatureConfig config) => '''
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

part 'multiple_${config.featureName}_event.dart';
part 'multiple_${config.featureName}_state.dart';

final multiple${config.pascalCase}Bloc = Multiple${config.pascalCase}Bloc();

class Multiple${config.pascalCase}Bloc extends Bloc<Multiple${config.pascalCase}Event, Multiple${config.pascalCase}State> {
  Multiple${config.pascalCase}Bloc() : super(Multiple${config.pascalCase}Initial()) {
    on<FetchMultiple${config.pascalCase}>(_fetch${config.pascalCase});
  }

  Future<void> _fetch${config.pascalCase}(
    FetchMultiple${config.pascalCase} event,
    Emitter<Multiple${config.pascalCase}State> emit,
  ) async {
    emit(Multiple${config.pascalCase}Loading());
    final params = ${config.pascalCase}Params();
    final res = await multiple${config.pascalCase}UseCase.call(params);
    res.fold(
      (l) => emit(Multiple${config.pascalCase}Loaded(l)),
      (r) => emit(Multiple${config.pascalCase}Error(r)),
    );
  }
}
''';
