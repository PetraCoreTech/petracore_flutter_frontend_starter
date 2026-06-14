import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String userLocationModelTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';

part 'user_location_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserLocation {
  UserLocation({
    this.address = '',
    this.state,
    this.country,
    this.street,
    this.city,
    this.postalCode,
    this.placeName,
    this.lat,
    this.lng,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _\$UserLocationFromJson(json);

  final String address;
  final String? state;
  final String? country;
  final String? street;
  final String? city;
  final String? postalCode;
  final String? placeName;
  final double? lat;
  final double? lng;

  Map<String, dynamic> toJson() => _\$UserLocationToJson(this);

  static UserLocation? maybeFromJson(Map<String, dynamic>? json) {
    if (json != null) return UserLocation.fromJson(json);
    return null;
  }
}
''';
