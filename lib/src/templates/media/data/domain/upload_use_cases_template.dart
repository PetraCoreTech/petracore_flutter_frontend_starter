import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadUseCasesTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/delete_upload_dto.dart';
import 'package:${config.packageName}/features/media/data/remote/upload/params/upload_params.dart';
import 'package:${config.packageName}/features/media/data/remote/upload/upload_repository.dart';
import 'package:dartz/dartz.dart';

final singleUploadUseCase = SingleUploadUseCase();
final multipleUploadUseCase = MultipleUploadUseCase();
final deleteUploadUseCase = DeleteUploadUseCase();

class SingleUploadUseCase extends UseCase<AttachedMedia, UploadParams> {
  @override
  Future<Either<AttachedMedia, ErrorResponse>> call(UploadParams params) {
    return uploadRepository.uploadResource(params);
  }
}

class MultipleUploadUseCase
    extends UseCase<List<AttachedMedia>, MultipleUploadParams> {
  @override
  Future<Either<List<AttachedMedia>, ErrorResponse>> call(
      MultipleUploadParams params) {
    return uploadRepository.uploadResources(params);
  }
}

class DeleteUploadUseCase extends UseCase<SuccessResponse, DeleteUploadDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
      DeleteUploadDto params) {
    return uploadRepository.deleteResource(params);
  }
}
''';
