import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String nearbyPlaceModelTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';
import 'package:${config.packageName}/features/map/map_index.dart';

part 'nearby_place_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NearbyPlace {
  NearbyPlace({
    this.businessStatus,
    this.lat,
    this.lng,
    this.icon,
    this.name,
    this.placeId,
    this.vicinity,
    this.rating,
    this.userRatingsTotal,
    this.types,
  });

  factory NearbyPlace.fromJson(Map<String, dynamic> json) =>
      _\$NearbyPlaceFromJson(json);

  @BusinessStatusConverter()
  final BusinessStatus? businessStatus;

  @JsonKey(readValue: LocationParser.readStatus)
  final double? lat;

  @JsonKey(readValue: LocationParser.readStatus)
  final double? lng;

  final String? icon;
  final String? name;
  final String? placeId;
  final String? vicinity;
  final double? rating;
  final int? userRatingsTotal;
  final List<String>? types;

  Map<String, dynamic> toJson() => _\$NearbyPlaceToJson(this);
}
''';
