import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String fileUploadDtoTemplate(ProjectConfig config) => '''
class FileUploadDto {
  FileUploadDto({
    required this.name,
    required this.size,
    this.path,
    this.author,
    this.fileBytes,
    this.mimeType,
  });
  final String? path;
  final String? author;
  final List<int>? fileBytes;
  final String name;
  final double size;
  final String? mimeType;
  }
''';
