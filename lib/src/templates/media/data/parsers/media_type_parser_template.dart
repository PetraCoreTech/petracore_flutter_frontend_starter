import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaTypeParserTemplate(ProjectConfig config) => '''
import 'package:json_annotation/json_annotation.dart';

class MimeTypeConverter implements JsonConverter<String?, String?> {
  const MimeTypeConverter();

  @override
  String? fromJson(String? json) => json;

  @override
  String? toJson(String? object) => object;
}
''';
