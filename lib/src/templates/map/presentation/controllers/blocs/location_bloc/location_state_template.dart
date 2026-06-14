String locationStateTemplate() => '''
part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  LocationLoaded(this.location);
  final UserLocation location;
}

final class LocationError extends LocationState {
  LocationError(this.error);
  final ErrorResponse error;
}
''';
