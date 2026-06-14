String placeParamsTemplate() => '''
class PlaceParams {
  PlaceParams({this.lat, this.lng, this.radius, this.type});

  final double? lat;
  final double? lng;
  final double? radius;
  final String? type;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (lat != null && lng != null) {
      json['location'] = '\$lat,\$lng';
    }
    json['radius'] = radius ?? 50000;
    json['type'] = type ?? 'locality';
    return json;
  }
}
''';
