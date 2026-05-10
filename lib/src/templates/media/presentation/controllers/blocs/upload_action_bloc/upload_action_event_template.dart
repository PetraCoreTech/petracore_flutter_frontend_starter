import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadActionEventTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:${config.packageName}/features/media/data/remote/cloudinary/dtos/delete_upload_dto.dart';
import 'package:equatable/equatable.dart';

sealed class UploadActionEvent extends Equatable {
  const UploadActionEvent();

  @override
  List<Object?> get props => [];
}

final class UploadSingleFile extends UploadActionEvent {
  final AttachedMedia file;
  const UploadSingleFile(this.file);

  @override
  List<Object?> get props => [file];
}

final class UploadMultipleFiles extends UploadActionEvent {
  final List<AttachedMedia> files;
  const UploadMultipleFiles(this.files);

  @override
  List<Object?> get props => [files];
}

final class DeleteUpload extends UploadActionEvent {
  final String? publicId;
  final String? url;
  final List<String>? publicIds;
  final List<String>? urls;
  final bool isMultiple;

  const DeleteUpload({
    this.publicId,
    this.url,
    this.publicIds,
    this.urls,
    this.isMultiple = false,
  });

  @override
  List<Object?> get props => [publicId, url, publicIds, urls, isMultiple];
}
''';
