import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationRepositoryTemplate(ProjectConfig config) => '''
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

final locationRepository = LocationRepository();

class LocationRepository {
  Future<Either<UserLocation, ErrorResponse>> getLocation() async {
    try {
      if (await LocationHelper.checkPermission()) {
        final data = await location.getLocation();
        final res = await LocationHelper.parseLocation(data);
        return Left(res);
      } else {
        return Right(ErrorResponse(message: 'Permission not granted!'));
      }
    } on PlatformException {
      return Right(ErrorResponse(message: 'Error when fetching location!'));
    } catch (e) {
      return Right(ErrorResponse(message: 'Error when fetching location!'));
    }
  }

  Stream<UserLocation?> onLocationChanged() async* {
    if (await LocationHelper.checkPermission()) {
      yield* location.onLocationChanged.map<UserLocation?>((data) {
        UserLocation? loc;
        LocationHelper.parseLocation(data).then((v) => loc = v);
        return loc;
      });
    }
  }

  Future<Either<List<NearbyPlace>, ErrorResponse>> getNearbyPlaces(
    PlaceParams? params,
  ) async {
    try {
      final response =
          await locationService.getNearbyPlaces(queryParams: params?.toJson());
      final decoded = response.data as Map<String, dynamic>;
      final places = decoded['results'] as List<dynamic>;
      final nearbyPlaces =
          places.map((e) => NearbyPlace.fromJson(e as Map<String, dynamic>)).toList();
      return Left(nearbyPlaces);
    } on DioException catch (e) {
      return Right(ApiError.handleError(e));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
