import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String nearbyPlacesCubitTemplate(ProjectConfig config) => '''
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:${config.packageName}/features/map/data/models/nearby_place_model.dart';

final nearbyPlacesCubit = NearbyPlacesCubit();

class NearbyPlacesCubit extends Cubit<List<NearbyPlace>> with HydratedMixin {
  NearbyPlacesCubit() : super([]) {
    hydrate();
  }

  void setNearbyPlaces(List<NearbyPlace> value) => emit(value);

  @override
  List<NearbyPlace>? fromJson(Map<String, dynamic> json) {
    final data = json['value'] as List<dynamic>;
    return data
        .map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic>? toJson(List<NearbyPlace> state) {
    return {'value': state.map((e) => e.toJson()).toList()};
  }
}
''';
