import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaRepositoryTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/enums/media_type.dart';
import 'package:${config.packageName}/features/media/data/extensions/media_type_extension.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

final mediaRepository = MediaRepository._();

class MediaRepository {
  MediaRepository._();

  final ImagePicker _picker = ImagePicker();

  Future<Either<List<AttachedMedia>, ErrorResponse>> pickImages(
      String author) async {
    try {
      final files = await _picker.pickMultiImage();
      if (files.isEmpty) {
        return const Right(ErrorResponse(message: 'No images selected'));
      }
      final mediaList = files.map((file) {
        return AttachedMedia(
          name: file.name,
          path: file.path,
          author: author,
          size: 0,
          mediaType: file.name.split('.').last.mediaType,
        );
      }).toList();
      return Left(mediaList);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }

  Future<Either<AttachedMedia, ErrorResponse>> pickImage(
    String author, {
    ImageSource? source,
  }) async {
    try {
      final file = await _picker.pickImage(source: source ?? ImageSource.gallery);
      if (file == null) {
        return const Right(ErrorResponse(message: 'No image selected'));
      }
      final media = AttachedMedia(
        name: file.name,
        path: file.path,
        author: author,
        size: 0,
        mediaType: file.name.split('.').last.mediaType,
      );
      return Left(media);
    } catch (e) {
      return Right(ErrorResponse(message: e.toString()));
    }
  }
}
''';
