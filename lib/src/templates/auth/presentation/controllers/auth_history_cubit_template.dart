import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String authHistoryCubitTemplate(ProjectConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/auth_index.dart';
import 'package:${config.projectName}/features/shared/presentation/controllers/key_values.dart';

final authHistoryCubit = AuthHistoryCubit();

class AuthHistoryCubit extends Cubit<List<AuthHistory>> with HydratedMixin {
  AuthHistoryCubit() : super([]) {
    hydrate();
  }

  void record(AuthHistory history) => emit([...state, history]);

  void reset() => emit([]);

  @override
  List<AuthHistory>? fromJson(Map<String, dynamic> json) {
    final data = json[KeyValues.value] as List<dynamic>;
    final histories = data.map((e) => AuthHistory.fromJson(e as Json)).toList();
    return histories;
  }

  @override
  Map<String, dynamic>? toJson(List<AuthHistory> state) {
    final json = Json();
    json[KeyValues.value] = state.map((e) => e.toJson()).toList();
    return json;
  }
}
''';
