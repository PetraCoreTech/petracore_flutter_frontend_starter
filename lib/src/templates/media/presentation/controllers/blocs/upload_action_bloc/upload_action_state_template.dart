import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadActionStateTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:${config.packageName}/features/media/data/models/attached_media_model.dart';
import 'package:equatable/equatable.dart';

sealed class UploadActionState extends Equatable {
  const UploadActionState();

  @override
  List<Object?> get props => [];
}

final class UploadActionInitial extends UploadActionState {
  const UploadActionInitial();
}

final class UploadActionLoading extends UploadActionState {
  const UploadActionLoading();
}

final class FileUploading extends UploadActionState {
  final double progress;
  const FileUploading(this.progress);

  @override
  List<Object?> get props => [progress];
}

final class FileUploaded extends UploadActionState {
  final AttachedMedia file;
  const FileUploaded(this.file);

  @override
  List<Object?> get props => [file];
}

final class FilesUploaded extends UploadActionState {
  final List<AttachedMedia> files;
  const FilesUploaded(this.files);

  @override
  List<Object?> get props => [files];
}

final class UploadDeleted extends UploadActionState {
  final SuccessResponse response;
  const UploadDeleted(this.response);

  @override
  List<Object?> get props => [response];
}

final class UploadActionError extends UploadActionState {
  final ErrorResponse error;
  const UploadActionError(this.error);

  @override
  List<Object?> get props => [error];
}
''';
