import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadActionStateTemplate(ProjectConfig config) => '''
part of 'download_action_bloc.dart';

sealed class DownloadActionState extends Equatable {
  const DownloadActionState();

  @override
  List<Object?> get props => [];
}

final class DownloadActionInitial extends DownloadActionState {
  const DownloadActionInitial();
}

final class DownloadActionLoading extends DownloadActionState {
  const DownloadActionLoading();
}

final class DownloadSuccessful extends DownloadActionState {
  const DownloadSuccessful(this.response);
  final SuccessResponse response;

  @override
  List<Object?> get props => [response];
}

final class DownloadActionError extends DownloadActionState {
  const DownloadActionError(this.error);
  final ErrorResponse error;

  @override
  List<Object?> get props => [error];
}
''';
