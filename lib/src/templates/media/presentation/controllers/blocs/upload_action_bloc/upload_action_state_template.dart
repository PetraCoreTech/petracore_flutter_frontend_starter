import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String uploadActionStateTemplate(ProjectConfig config) => '''
part of 'upload_action_bloc.dart';

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
  const FileUploading(this.progress);
  final double progress;

  @override
  List<Object?> get props => [progress];
}

final class FileUploaded extends UploadActionState {
  const FileUploaded(this.file);
  final AttachedMedia file;

  @override
  List<Object?> get props => [file];
}

final class FilesUploaded extends UploadActionState {
  const FilesUploaded(this.files);
  final List<AttachedMedia> files;

  @override
  List<Object?> get props => [files];
}

final class UploadDeleted extends UploadActionState {
  const UploadDeleted(this.response);
  final SuccessResponse response;

  @override
  List<Object?> get props => [response];
}

final class UploadActionError extends UploadActionState {
  const UploadActionError(this.error);
  final ErrorResponse error;

  @override
  List<Object?> get props => [error];
}
''';
