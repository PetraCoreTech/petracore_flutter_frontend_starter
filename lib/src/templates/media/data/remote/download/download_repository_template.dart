import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadRepositoryTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/remote/download/dtos/download_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:file_saver/file_saver.dart';

final downloadRepository = DownloadRepository._();

class DownloadRepository {
  DownloadRepository._();

  Future<Either<SuccessResponse, ErrorResponse>> downloadResource(
      DownloadDto dto) async {
    try {
      await FileSaver.instance.saveFile(
        name: dto.title,
        link: LinkType.url,
        url: dto.url,
      );
      return const Left(SuccessResponse(message: 'File downloaded'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  Future<Either<SuccessResponse, ErrorResponse>> downloadResources(
      List<DownloadDto> dtos) async {
    try {
      for (final dto in dtos) {
        await FileSaver.instance.saveFile(
          name: dto.title,
          link: LinkType.url,
          url: dto.url,
        );
      }
      return const Left(SuccessResponse(message: 'Files downloaded'));
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
