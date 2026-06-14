import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String nearbyPlacesBlocTemplate(ProjectConfig config) => '''
import 'package:bloc/bloc.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

part 'nearby_places_event.dart';
part 'nearby_places_state.dart';

final nearbyPlacesBloc = NearbyPlacesBloc();

class NearbyPlacesBloc extends Bloc<NearbyPlacesEvent, NearbyPlacesState> {
  NearbyPlacesBloc() : super(NearbyPlacesInitial()) {
    on<FetchNearbyPlaces>(_fetchNearbyPlaces);
  }

  Future<void> _fetchNearbyPlaces(
    FetchNearbyPlaces event,
    Emitter<NearbyPlacesState> emit,
  ) async {
    emit(NearbyPlacesLoading());
    final params = PlaceParams(
      lat: event.lat,
      lng: event.lng,
      radius: event.radius,
      type: event.type,
    );
    final res = await nearbyPlaceUseCase.call(params);
    res.fold(
      (l) => emit(NearbyPlacesLoaded(l)),
      (r) => emit(NearbyPlacesError(r)),
    );
  }
}
''';
