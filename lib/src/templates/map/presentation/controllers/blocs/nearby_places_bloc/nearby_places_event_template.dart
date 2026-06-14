String nearbyPlacesEventTemplate() => '''
part of 'nearby_places_bloc.dart';

@immutable
sealed class NearbyPlacesEvent {}

final class FetchNearbyPlaces extends NearbyPlacesEvent {
  FetchNearbyPlaces({this.lat, this.lng, this.radius, this.type});
  final double? lat;
  final double? lng;
  final double? radius;
  final String? type;
}
''';
