import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationCubitTemplate(ProjectConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.packageName}/features/map/data/models/user_location_model.dart';

final locationCubit = LocationCubit();

class LocationCubit extends Cubit<UserLocation?> with HydratedMixin {
  LocationCubit() : super(null) {
    hydrate();
  }

  void setLocation(UserLocation value) => emit(value);

  @override
  UserLocation? fromJson(Map<String, dynamic> json) {
    return UserLocation.maybeFromJson(
      json['value'] as Map<String, dynamic>?,
    );
  }

  @override
  Map<String, dynamic>? toJson(UserLocation? state) {
    return {'value': state?.toJson()};
  }
}
''';
