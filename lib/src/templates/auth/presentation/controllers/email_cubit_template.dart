import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String emailCubitTemplate(ProjectConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/shared/presentation/controllers/key_value.dart';

final emailCubit = EmailCubit();

class EmailCubit extends Cubit<String> with HydratedMixin {
  EmailCubit() : super('') {
    hydrate();
  }

  void setEmail(String email) => emit(email);

  @override
  String? fromJson(Json json) => json[KeyValues.value] as String;

  @override
  Json? toJson(String state) {
    final json = Json();
    json[KeyValues.value] = state;
    return json;
  }
}
''';
