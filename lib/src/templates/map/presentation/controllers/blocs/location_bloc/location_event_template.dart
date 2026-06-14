String locationEventTemplate() => '''
part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

final class FetchLocation extends LocationEvent {}
''';
