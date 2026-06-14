import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationBlocTemplate(ProjectConfig config) => '''
import 'package:bloc/bloc.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

part 'location_event.dart';
part 'location_state.dart';

final locationBloc = LocationBloc();

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<FetchLocation>(_fetchLocation);
  }

  Future<void> _fetchLocation(
    FetchLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    final res = await locationUseCase.call(null);
    res.fold(
      (l) => emit(LocationLoaded(l)),
      (r) => emit(LocationError(r)),
    );
  }
}
''';
