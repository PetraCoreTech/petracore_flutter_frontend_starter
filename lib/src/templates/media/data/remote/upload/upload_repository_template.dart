import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadRepositoryTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/cloudinary_service.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/delete_upload_dto.dart';
import 'package:${config.packageName}/features/media/data/remote/upload/params/upload_params.dart';
import 'package:dartz/dartz.dart';

final uploadRepository = UploadRepository(cloudinaryService);

class UploadRepository {
  UploadRepository(this.cloudinaryService);

  final CloudinaryService cloudinaryService;


  Future<Either<AttachedMedia, ErrorResponse>> uploadResource(
      UploadParams params) async {
    try {
      final response = await cloudinaryService.uploadResource(
        dto: params.uploadDto,
        resourceType: params.resourceType,
        fileName: params.fileName,
        progressCallback: params.progressCallback,
      );
      final attached = AttachedMedia(
        name: params.uploadDto.name,
        url: response.url,
        publicId: response.publicId,
        size: params.uploadDto.size,
        mimeType: params.uploadDto.mimeType,
      );
      return Left(attached);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  Future<Either<List<AttachedMedia>, ErrorResponse>> uploadResources(
      MultipleUploadParams params) async {
    try {
      final responses = await cloudinaryService.uploadResources(
        files: params.files,
        resourceType: params.resourceType,
        progressCallback: params.progressCallback,
      );
      final attachedList = <AttachedMedia>[];
      for (var i = 0; i < responses.length; i++) {
        attachedList.add(AttachedMedia(
          name: params.files[i].name,
          url: responses[i].url,
          publicId: responses[i].publicId,
          size: params.files[i].size,
          mimeType: params.files[i].mimeType,
        ));
      }
      return Left(attachedList);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  Future<Either<SuccessResponse, ErrorResponse>> deleteResource(
      DeleteUploadDto dto) async {
    try {
      await cloudinaryService.deleteResource(
        publicId: dto.publicId,
        url: dto.url,
        publicIds: dto.publicIds,
        urls: dto.urls,
        isMultiple: dto.isMultiple,
      );
      return Left(SuccessResponse(message: 'Resource deleted'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
