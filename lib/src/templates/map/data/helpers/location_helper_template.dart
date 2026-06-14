import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String locationHelperTemplate(ProjectConfig config) => '''
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

final location = Location();

class LocationHelper {
  LocationHelper._();

  static Future<UserLocation> getLocationFromLatLng({
    double? lat,
    double? lng,
  }) async {
    final loc = await getPlaceMark(lat ?? 0, lng ?? 0);
    return UserLocation(
      lat: lat,
      lng: lng,
      state: loc.administrativeArea,
      country: loc.country,
      street: loc.street,
      city: loc.locality,
      placeName: loc.name,
      address: [
        loc.street,
        loc.locality,
        loc.postalCode,
        loc.administrativeArea,
        loc.country,
      ].join(', '),
    );
  }

  static Future<Placemark> getPlaceMark(double lat, double lng) async {
    final res = await placemarkFromCoordinates(lat, lng);
    return res.first;
  }

  static Future<UserLocation> parseLocation(LocationData? data) async {
    final res = await placemarkFromCoordinates(
      data!.latitude ?? 0,
      data.longitude ?? 0,
    );
    final i = res.first;
    return UserLocation(
      state: i.administrativeArea,
      country: i.country,
      street: i.street,
      city: i.locality,
      placeName: i.name,
      lat: data.latitude,
      lng: data.longitude,
      address: [
        i.street,
        i.locality,
        i.postalCode,
        i.administrativeArea,
        i.country,
      ].join(', '),
    );
  }

  static Future<bool> checkPermission() async {
    if (await _checkService()) {
      final permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        await location.requestPermission();
      }
    }
    return (await location.hasPermission()) == PermissionStatus.granted;
  }

  static Future<bool> _checkService() async {
    try {
      final isEnabled = await location.serviceEnabled();
      if (!isEnabled) await location.requestService();
    } on PlatformException {
      await _checkService();
    }
    return location.serviceEnabled();
  }
}
''';
