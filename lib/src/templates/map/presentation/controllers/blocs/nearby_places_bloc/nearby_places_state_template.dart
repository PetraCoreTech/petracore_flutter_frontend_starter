String nearbyPlacesStateTemplate() => '''
part of 'nearby_places_bloc.dart';

@immutable
sealed class NearbyPlacesState {}

final class NearbyPlacesInitial extends NearbyPlacesState {}

final class NearbyPlacesLoading extends NearbyPlacesState {}

final class NearbyPlacesLoaded extends NearbyPlacesState {
  NearbyPlacesLoaded(this.nearbyPlaces);
  final List<NearbyPlace> nearbyPlaces;
}

final class NearbyPlacesError extends NearbyPlacesState {
  NearbyPlacesError(this.error);
  final ErrorResponse error;
}
''';
