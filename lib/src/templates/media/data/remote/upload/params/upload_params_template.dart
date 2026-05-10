import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadParamsTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/file_upload_dto.dart';
import 'package:cloudinary/cloudinary.dart';

class UploadParams {
  final FileUploadDto uploadDto;
  final CloudinaryResourceType? resourceType;
  final String? fileName;
  final void Function(int count, int total)? progressCallback;

  UploadParams({
    required this.uploadDto,
    this.resourceType,
    this.fileName,
    this.progressCallback,
  });
}

class MultipleUploadParams {
  final List<FileUploadDto> files;
  final CloudinaryResourceType? resourceType;
  final void Function(int count, int total)? progressCallback;

  MultipleUploadParams({
    required this.files,
    this.resourceType,
    this.progressCallback,
  });
}
''';
