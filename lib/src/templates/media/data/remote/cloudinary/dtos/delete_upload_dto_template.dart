import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String deleteUploadDtoTemplate(ProjectConfig config) => '''
class DeleteUploadDto {
  final String? url;
  final String? publicId;
  final List<String>? urls;
  final List<String>? publicIds;
  final bool isMultiple;

  DeleteUploadDto({
    this.url,
    this.publicId,
    this.urls,
    this.publicIds,
    this.isMultiple = false,
  });
}
''';
