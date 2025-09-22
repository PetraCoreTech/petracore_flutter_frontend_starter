import 'package:petracore_flutter_frontend_starter/petracore_flutter_frontend_starter.dart';

String userCubitTemplate(ProjectConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.projectName}/core/core.dart';
import 'package:${config.projectName}/features/auth/data/models/user_model.dart';
import 'package:${config.projectName}/features/shared/presentation/controllers/key_value.dart';

final userCubit = UserCubit();

class UserCubit extends Cubit<User?> with HydratedMixin {
  UserCubit() : super(null) {
    hydrate();
  }

  void setUser(User value) => emit(value);

  void reset() => emit(null);

  @override
  User? fromJson(Map<String, dynamic> json) =>
      User.maybeFromJson(json[KeyValues.value] as Json?);

  @override
  Map<String, dynamic>? toJson(User? state) {
    final json = Json();
    json[KeyValues.value] = state?.toJson();
    return json;
  }
}
''';
