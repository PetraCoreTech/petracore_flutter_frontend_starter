import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaTypeParserTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';

class MediaTypeParser implements JsonConverter<MediaType, String> {
  const MediaTypeParser();

  @override
  MediaType fromJson(String json) => json.mediaType;

  @override
  String toJson(MediaType object) => object.name;

  static Object? readStatus(Map<dynamic, dynamic> json, String key) {
    final status = json[key];
    if (status is Map) return status['type'];
    return status;
  }

  static MediaType? typeFromJson(String? json) {
    if (json == null) return null;
    return json.mediaType;
  }
}
''';
