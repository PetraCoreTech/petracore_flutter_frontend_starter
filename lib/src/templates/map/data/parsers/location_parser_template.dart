String locationParserTemplate() => '''
class LocationParser {
  LocationParser._();

  static Object? readStatus(Map<dynamic, dynamic> json, String key) {
    if (json.containsKey(key)) return json[key];
    final geometry = json['geometry'] as Map<String, dynamic>;
    final location = geometry['location'] as Map<String, dynamic>;
    return location[key];
  }
}
''';
