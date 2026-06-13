import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String fileUploadDtoTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';

class FileUploadDto {
  FileUploadDto({
    required this.name,
    required this.size,
    required this.fileType,
    this.path,
    this.author,
    this.fileBytes,
  });
  final String? path;
  final String? author;
  final List<int>? fileBytes;
  final String name;
  final double size;
  final MediaType fileType;
''';
