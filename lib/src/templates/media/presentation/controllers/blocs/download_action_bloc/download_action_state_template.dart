import 'package:petracore_flutter_frontend_starter/src/generators/project_generator.dart';

String downloadActionStateTemplate(ProjectConfig config) => '''
import 'package:${config.packageName}/core/core.dart';
import 'package:equatable/equatable.dart';

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
  final SuccessResponse response;
  const DownloadSuccessful(this.response);

  @override
  List<Object?> get props => [response];
}

final class DownloadActionError extends DownloadActionState {
  final ErrorResponse error;
  const DownloadActionError(this.error);

  @override
  List<Object?> get props => [error];
}
''';
