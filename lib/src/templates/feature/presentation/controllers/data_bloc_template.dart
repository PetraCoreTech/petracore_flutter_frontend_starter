import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String dataBlocTemplate(FeatureConfig config) => '''
import 'package:${config.projectConfig.projectName}/core/core.dart';
import 'package:${config.projectConfig.projectName}/features/${config.featureName}/${config.featureName}_index.dart';

part 'multiple_${config.featureName}_event.dart';
part 'multiple_${config.featureName}_state.dart';

final multiple${config.pascalEntity}Bloc = Multiple${config.pascalEntity}Bloc();

class Multiple${config.pascalEntity}Bloc extends Bloc<Multiple${config.pascalEntity}Event, Multiple${config.pascalEntity}State> {
  Multiple${config.pascalEntity}Bloc() : super(Multiple${config.pascalEntity}Initial()) {
    on<FetchMultiple${config.pascalEntity}>(_fetch${config.pascalEntity});
  }

  Future<void> _fetch${config.pascalEntity}(
    FetchMultiple${config.pascalEntity} event,
    Emitter<Multiple${config.pascalEntity}State> emit,
  ) async {
    emit(Multiple${config.pascalEntity}Loading());
    final params = ${config.pascalEntity}Params();
    final res = await multiple${config.pascalEntity}UseCase.call(params);
    res.fold(
      (l) => emit(Multiple${config.pascalEntity}Loaded(l)),
      (r) => emit(Multiple${config.pascalEntity}Error(r)),
    );
  }
}
''';
