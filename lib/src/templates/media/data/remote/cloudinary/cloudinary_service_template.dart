import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String cloudinaryServiceTemplate(ProjectConfig config) => '''
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/file_upload_dto.dart';

final cloudinaryService = CloudinaryService._();

final class CloudinaryService {
  CloudinaryService._();

  static const _cloudinarySecretKey =
      String.fromEnvironment('CLOUDINARY_SECRET_KEY');
  static const _cloudName = String.fromEnvironment('CLOUD_NAME');
  static const _cloudinaryAPIKey =
      String.fromEnvironment('CLOUDINARY_API_KEY');

  Cloudinary get cloudinary => Cloudinary.full(
        apiKey: _cloudinaryAPIKey,
        apiSecret: _cloudinarySecretKey,
        cloudName: _cloudName,
      );

  Future<CloudinaryResponse> uploadResource({
    required FileUploadDto dto,
    CloudinaryResourceType? resourceType,
    String? fileName,
    void Function(int, int)? progressCallback,
  }) async {
    final response = await cloudinary.uploadResource(
      CloudinaryUploadResource(
        filePath: dto.path,
        fileBytes: dto.fileBytes,
        resourceType: resourceType ?? CloudinaryResourceType.image,
        fileName: fileName ?? dto.name,
        progressCallback: progressCallback,
      ),
    );
    return response;
  }

  Future<List<CloudinaryResponse>> uploadResources({
    required List<FileUploadDto> files,
    CloudinaryResourceType? resourceType,
    void Function(int, int)? progressCallback,
  }) async {
    final responses = <CloudinaryResponse>[];
    for (var i = 0; i < files.length; i++) {
      final response = await uploadResource(
        dto: files[i],
        resourceType: resourceType,
        progressCallback: progressCallback,
      );
      responses.add(response);
      progressCallback?.call(i + 1, files.length);
    }
    return responses;
  }

  Future<CloudinaryResponse> deleteResource({
    String? publicId,
    String? url,
    List<String>? publicIds,
    List<String>? urls,
    bool isMultiple = false,
    CloudinaryResourceType? resourceType,
  }) async {
    if (isMultiple) {
      return cloudinary.deleteResources(
        publicIds: publicIds,
        urls: urls,
        resourceType: resourceType ?? CloudinaryResourceType.image,
      );
    }
    return cloudinary.deleteResource(
      publicId: publicId,
      url: url,
      resourceType: resourceType ?? CloudinaryResourceType.image,
    );
  }
}
''';
