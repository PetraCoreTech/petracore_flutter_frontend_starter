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
    final authorVal = author ?? context.read<UserCubit>().state.email;
    final result = await mediaRepository.pickImages(authorVal);
    result.fold(
      (files) => onImagePicked?.call(files),
      (error) => ToastHelper.showError(context, message: error.message),
    );
  }

  void pickImage({
    String? author,
    ValueChanged<AttachedMedia>? onImagePicked,
  }) async {
    final authorVal = author ?? context.read<UserCubit>().state.email;
    final result = await mediaRepository.pickImage(authorVal);
    result.fold(
      (file) => onImagePicked?.call(file),
      (error) => ToastHelper.showError(context, message: error.message),
    );
  }

  void showFullDisplay({
    List<AttachedMedia>? attachedMedia,
    List<String>? media,
  }) {
    DialogHelper.showDialog(
      context,
      MediaDisplay(attachedMedia: attachedMedia, media: media),
    );
  }
}
''';
