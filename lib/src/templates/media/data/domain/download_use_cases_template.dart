import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadUseCasesTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/remote/download/dtos/download_dto.dart';
import 'package:${config.packageName}/features/media/data/remote/download/download_repository.dart';
import 'package:dartz/dartz.dart';

final singleDownloadUseCase = SingleDownloadUseCase();
final multipleDownloadUseCase = MultipleDownloadUseCase();

class SingleDownloadUseCase extends UseCase<SuccessResponse, DownloadDto> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(DownloadDto params) {
    return downloadRepository.downloadResource(params);
  }
}

class MultipleDownloadUseCase
    extends UseCase<SuccessResponse, List<DownloadDto>> {
  @override
  Future<Either<SuccessResponse, ErrorResponse>> call(
      List<DownloadDto> params) {
    return downloadRepository.downloadResources(params);
  }
}
''';
