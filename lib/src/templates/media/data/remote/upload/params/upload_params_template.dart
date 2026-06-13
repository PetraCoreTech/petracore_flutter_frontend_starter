import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadParamsTemplate(ProjectConfig config) => '''
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/file_upload_dto.dart';

class UploadParams {
  UploadParams({
    required this.uploadDto,
    this.resourceType,
    this.fileName,
    this.progressCallback,
  });
  final FileUploadDto uploadDto;
  final CloudinaryResourceType? resourceType;
  final String? fileName;
  final void Function(int count, int total)? progressCallback;
}

class MultipleUploadParams {
  MultipleUploadParams({
    required this.files,
    this.resourceType,
    this.progressCallback,
  });
  final List<FileUploadDto> files;
  final CloudinaryResourceType? resourceType;
  final void Function(int count, int total)? progressCallback;
}
''';
