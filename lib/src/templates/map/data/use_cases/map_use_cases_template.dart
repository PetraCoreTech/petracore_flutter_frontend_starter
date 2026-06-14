import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mapUseCasesTemplate(ProjectConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

final locationUseCase = LocationUseCase();

class LocationUseCase extends UseCase<UserLocation, void> {
  @override
  Future<Either<UserLocation, ErrorResponse>> call(void params) async {
    final res = await locationRepository.getLocation();
    return res.fold(Left.new, Right.new);
  }
}

final nearbyPlaceUseCase = NearbyPlaceUseCase();

class NearbyPlaceUseCase extends UseCase<List<NearbyPlace>, PlaceParams?> {
  @override
  Future<Either<List<NearbyPlace>, ErrorResponse>> call(
    PlaceParams? params,
  ) async {
    final res = await locationRepository.getNearbyPlaces(params);
    return res.fold(Left.new, Right.new);
  }
}
''';
