import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String mediaHelperTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:${config.packageName}/features/media/data/remote/media_repository.dart';
import 'package:${config.packageName}/features/media/presentation/widgets/media_display.dart';

class MediaHelper {
  MediaHelper(this.context);
  final BuildContext context;

  void pickImages({
    String? author,
    ValueChanged<List<AttachedMedia>>? onImagePicked,
  }) async {
    final result = await mediaRepository.pickImages(author ?? '');
    result.fold(
      (files) => onImagePicked?.call(files),
      (error) => ToastHelper.showError(context, error.message),
    );
  }

  void pickImage({
    String? author,
    ValueChanged<AttachedMedia>? onImagePicked,
  }) async {
    final result = await mediaRepository.pickImage(author ?? '');
    result.fold(
      (file) => onImagePicked?.call(file),
      (error) => ToastHelper.showError(context, error.message),
    );
  }

  void showFullDisplay({
    List<AttachedMedia>? attachedMedia,
    List<String>? media,
    int index = 0,
  }) {
    showDialog(
      context: context,
      builder: (_) => MediaDisplay(
        attachedMedia: attachedMedia,
        media: media,
        index: index,
      ),
    );
  }
}
''';
